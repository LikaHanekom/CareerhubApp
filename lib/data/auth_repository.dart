import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';
import 'api_result.dart';
import 'dio_provider.dart' show apiBaseUrl;

part 'auth_repository.g.dart';

/// These two keys are the single source of truth for where tokens live in
/// secure storage. auth_interceptor.dart declares its own copies of these
/// exact strings — if the two ever diverge, the interceptor will read from
/// a different slot than this repository writes to, and every request
/// will look unauthenticated even right after a successful login.
///
/// _refreshTokenKey is currently never written to: this backend's
/// LoginResponse only returns a single Token, no refresh token. It's kept
/// here (and read as always-null in tryRefresh()) so the interceptor's
/// four-case structure in Part 7 stays intact and this repo doesn't need
/// restructuring if a refresh endpoint gets added later.
const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

/// AuthRepository gets its own plain Dio, deliberately NOT dioProvider.
/// dioProvider has AuthInterceptor attached — if login()/tryRefresh() ran
/// through it, a failed refresh call would trigger the same interceptor
/// that's already in the middle of handling a 401, recursing into its own
/// queueing logic with no way to ever resolve. A bare Dio with no
/// interceptors can't recurse into anything.
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    dio: Dio(BaseOptions(baseUrl: apiBaseUrl)),
    storage: const FlutterSecureStorage(),
  );
}

class AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  const AuthRepository({
    required Dio dio,
    required FlutterSecureStorage storage,
  })  : _dio = dio,
        _storage = storage;

  Future<String?> readAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  /// True if [token]'s `exp` claim is in the past, or if the token can't
  /// be decoded at all — an undecodable token is treated as expired
  /// rather than valid, since failing closed is the safe default here.
  bool isTokenExpired(String token) {
    final payload = _decodePayload(token);
    if (payload == null) return true;

    final exp = payload['exp'];
    if (exp is! int) return false;

    final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return expiry.isBefore(DateTime.now());
  }

  /// This backend's Me() endpoint reads claims via JwtRegisteredClaimNames
  /// (short JWT names like "sub", "unique_name") AND ClaimTypes.Role (the
  /// long ASP.NET URI form) in the same handler — which strongly suggests
  /// the token itself may mix both forms depending on how the token was
  /// built. This checks both forms for id/username so it doesn't silently
  /// return empty strings if the actual claim keys turn out to be the
  /// long URIs. Worth confirming against a real decoded token from your
  /// backend rather than trusting this guess long-term.
  ///
  /// This backend has no separate "email" claim — login is username-based
  /// — so User.email is populated with the username instead. If a real
  /// email claim shows up in your tokens, swap this to read it directly.
  User decodeUser(String token) {
    final payload = _decodePayload(token) ?? const {};

    final id = payload['sub'] as String? ??
        payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
        as String? ??
        '';

    final username = payload['unique_name'] as String? ??
        payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name']
        as String? ??
        '';

    return User(id: id, email: username, displayName: username);
  }

  Future<ApiResult<User>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        // LoginResponse only has one field: Token. No refresh token is
        // issued by this backend, so only the access token key is
        // written — _refreshTokenKey is deliberately never populated.
        final accessToken = data['token'] as String;

        await _storage.write(key: _accessTokenKey, value: accessToken);

        return Success(decodeUser(accessToken));
      }

      return const ServerFailure('Unexpected response from server.', 0);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      // AuthController.Login only ever returns 401 for bad credentials
      // (`if (result is null) return Unauthorized();`) — no 400 case
      // exists for this endpoint specifically.
      if (statusCode == 401) {
        return const ServerFailure(
          'Incorrect username or password.',
          401,
        );
      }
      return switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
            NetworkFailure('No internet connection. Please check your network.'),
        _ => ServerFailure(
          'The server returned an error.',
          statusCode ?? 0,
        ),
      };
    } catch (e) {
      return UnknownFailure('An unexpected error occurred: $e');
    }
  }

  /// AuthController has no /auth/refresh endpoint — login() never
  /// receives a refresh token to store, so _refreshTokenKey will always
  /// read back null here. This makes that explicit rather than sending a
  /// POST to a route that would just 404: a stored access token that's
  /// expired means the session is over, full stop, with this backend.
  ///
  /// The stored-token-but-unreadable case (corrupt storage, tampered
  /// value) is treated the same way as "no session" here — wiping
  /// storage before returning null, so a bad access token can't linger
  /// and get retried indefinitely by anything that calls this expecting
  /// a clean pass/fail signal.
  ///
  /// Kept as its own method (rather than deleted) so Part 5's build()
  /// and Part 7's interceptor don't need restructuring the day a real
  /// refresh endpoint gets added server-side — only this method's body
  /// would need to change.
  Future<User?> tryRefresh() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null) {
      await _storage.deleteAll();
      return null;
    }

    // Unreachable with the current backend — see note above — but kept
    // so the shape is ready if /auth/refresh is added later.
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final data = response.data as Map<String, dynamic>;
      final newAccessToken = data['token'] as String;
      await _storage.write(key: _accessTokenKey, value: newAccessToken);

      return decodeUser(newAccessToken);
    } catch (e) {
      await _storage.deleteAll();
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<ApiResult<String>> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'email': email,
        'password': password,
        'fullName': fullName,
        'role': role,
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final createdUsername = data['username'] as String;
        return Success(createdUsername);
      }

      return const ServerFailure('Unexpected response from server.', 0);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 409) {
        return const ServerFailure('Username or email already exists.', 409);
      }
      if (statusCode == 400) {
        return const ServerFailure('All fields are required.', 400);
      }

      return switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
            NetworkFailure('No internet connection. Please check your network.'),
        _ => ServerFailure('The server returned an error.', statusCode ?? 0),
      };
    } catch (e) {
      return UnknownFailure('An unexpected error occurred: $e');
    }
  }


  /// Decodes the middle segment of a JWT (the payload) from Base64URL.
  /// JWT payloads omit the trailing '=' padding Dart's base64 decoder
  /// normally requires, so it has to be re-added by hand before decoding
  /// — the number of '=' characters needed is (4 - length % 4) % 4.
  static Map<String, dynamic>? _decodePayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      var payloadSegment = parts[1];
      final padded = payloadSegment.padRight(
        payloadSegment.length + (4 - payloadSegment.length % 4) % 4,
        '=',
      );

      final decoded = utf8.decode(base64Url.decode(padded));
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }


  }

  //Stretch A Assignment2.4
  DateTime? getExpiry(String token) {
    final payload = _decodePayload(token);
    if (payload == null) return null;

    final exp = payload['exp'];
    if (exp is! int) return null;

    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }
}