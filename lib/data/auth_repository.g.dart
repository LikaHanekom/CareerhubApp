// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AuthRepository gets its own plain Dio, deliberately NOT dioProvider.
/// dioProvider has AuthInterceptor attached — if login()/tryRefresh() ran
/// through it, a failed refresh call would trigger the same interceptor
/// that's already in the middle of handling a 401, recursing into its own
/// queueing logic with no way to ever resolve. A bare Dio with no
/// interceptors can't recurse into anything.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// AuthRepository gets its own plain Dio, deliberately NOT dioProvider.
/// dioProvider has AuthInterceptor attached — if login()/tryRefresh() ran
/// through it, a failed refresh call would trigger the same interceptor
/// that's already in the middle of handling a 401, recursing into its own
/// queueing logic with no way to ever resolve. A bare Dio with no
/// interceptors can't recurse into anything.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// AuthRepository gets its own plain Dio, deliberately NOT dioProvider.
  /// dioProvider has AuthInterceptor attached — if login()/tryRefresh() ran
  /// through it, a failed refresh call would trigger the same interceptor
  /// that's already in the middle of handling a 401, recursing into its own
  /// queueing logic with no way to ever resolve. A bare Dio with no
  /// interceptors can't recurse into anything.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'3f0fa5944c936cfbd3a16ebc7ab86e425c6c79b8';
