import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Must be identical to the keys in auth_repository.dart. If these ever
// diverge, this interceptor reads from a different storage slot than
// AuthRepository writes to, and every request looks unauthenticated even
// immediately after a successful login.
const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

/// Attaches the stored access token to every outgoing request, and on a
/// 401 response, attempts a silent refresh before the error reaches the
/// UI — queueing any other requests that fail concurrently so only one
/// refresh call is ever made.
///
/// Deliberately has zero Riverpod imports: this is a plain Dio
/// interceptor, testable and reasoned about without any provider
/// context. onUnauthenticated is a plain closure (see auth_provider.dart)
/// rather than a direct call into Riverpod, specifically so this file
/// doesn't need to know providers exist at all.
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio retryDio;
  final void Function() onUnauthenticated;

  bool _isRefreshing = false;
  final List<Completer<String>> _queue = [];

   AuthInterceptor({
    required FlutterSecureStorage storage,
    required this.retryDio,
    required this.onUnauthenticated,
  }) : _storage = storage;

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Case 1 — not a 401 at all. Nothing to do with tokens here.
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // Case 2 — the 401 IS the refresh attempt itself. This is the guard
    // that stops case 4's own refresh POST from re-triggering this same
    // handler and recursing into case 3's unresolvable queue (see the
    // README's Q3 trace). The refresh token — if there even is one — is
    // definitively dead, so this ends the session immediately rather
    // than trying anything else.
    final isRefreshRequest =
    err.requestOptions.path.contains('/auth/refresh');
    if (isRefreshRequest) {
      _drainQueue(err);
      await _storage.deleteAll();
      onUnauthenticated();
      handler.next(err);
      return;
    }

    // Case 3 — a refresh is already in progress for a different failed
    // request. Queue behind it instead of starting a second refresh
    // call; wake up with whatever token that in-flight refresh
    // eventually produces (or fail the same way it fails).
    if (_isRefreshing) {
      final completer = Completer<String>();
      _queue.add(completer);
      try {
        final newToken = await completer.future;
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';
        final response = await retryDio.fetch(retryOptions);
        handler.resolve(response);
      } catch (_) {
        handler.next(err);
      }
      return;
    }

    // Case 4 — the first 401 to arrive with no refresh already running.
    // This one performs the actual refresh; everything else that fails
    // while it's in flight lands in case 3 above and waits on it.
    _isRefreshing = true;
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null) {
        // No refresh capability (this backend doesn't issue refresh
        // tokens at all right now — see auth_repository.dart) or the
        // session genuinely has nothing left to refresh with. Either
        // way: end the session.
        _drainQueue(err);
        await _storage.deleteAll();
        onUnauthenticated();
        handler.next(err);
        return;
      }

      final response = await retryDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      final newAccessToken = data['token'] as String;
      await _storage.write(key: _accessTokenKey, value: newAccessToken);

      for (final completer in _queue) {
        completer.complete(newAccessToken);
      }
      _queue.clear();

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final response2 = await retryDio.fetch(retryOptions);
      handler.resolve(response2);
    } catch (e) {
      _drainQueue(err);
      await _storage.deleteAll();
      onUnauthenticated();
    } finally {
      _isRefreshing = false;
    }
  }

  void _drainQueue(DioException err) {
    for (final completer in _queue) {
      completer.completeError(err);
    }
    _queue.clear();
  }
}