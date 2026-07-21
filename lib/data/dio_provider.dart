import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Shared by dioProvider below and by AuthRepository's own plain Dio, so
/// both clients always point at the same server. AuthRepository can't
/// watch this provider (that would pull in Riverpod-flavoured coupling
/// it's not supposed to have), so the key/default are duplicated as a
/// plain constant instead — kept here as the single source of truth for
/// what that duplicate must match.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5011/api/v1/',
);

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  return dio;
}