import 'dart:async';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_repository.dart';
import '../data/api_result.dart';
import '../models/auth_state.dart';
import '../models/user.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  Timer? _refreshTimer;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<AuthState> build() async {
    // Cancel any pending countdown/timer from a previous instance of this
    // notifier when it's torn down — e.g. via ref.invalidate after a
    // failed refresh in the interceptor.
    ref.onDispose(() => _refreshTimer?.cancel());

    final repo = ref.read(authRepositoryProvider);
    final token = await repo.readAccessToken();

    if (token == null) return const Unauthenticated();

    User user;

    if (repo.isTokenExpired(token)) {
      final refreshed = await repo.tryRefresh();
      if (refreshed == null) return const Unauthenticated();
      user = refreshed;
    } else {
      user = repo.decodeUser(token);
    }

    // A valid (or freshly refreshed) token exists. Gate it behind a
    // biometric check before returning Authenticated — this is the
    // Stretch B requirement: cold boot with a valid stored token still
    // requires the user to prove presence before the app unlocks.
    final biometricOk = await _tryBiometricAuth();
    if (!biometricOk) {
      await repo.logout(); // clears secure storage
      return const Unauthenticated();
    }

    _scheduleRefresh(repo);
    return Authenticated(user: user);
  }

  Future<bool> _tryBiometricAuth() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      if (!canCheck && !isSupported) return false;

      return await _localAuth.authenticate(
        localizedReason: 'Unlock CareerHub to continue',
        options: const AuthenticationOptions(
          biometricOnly: false, // allow device PIN/pattern as fallback
          stickyAuth: true,
        ),
      );
    } catch (_) {
      // Any platform exception (no enrolled biometrics, hardware
      // unavailable, prompt dismissed) fails safe to "not authenticated"
      // rather than leaving the notifier hanging in loading forever.
      return false;
    }
  }

  void _scheduleRefresh(AuthRepository repo) {
    _refreshTimer?.cancel();

    repo.readAccessToken().then((token) {
      if (token == null) return;
      final expiry = repo.getExpiry(token);
      if (expiry == null) return;

      final fireAt = expiry.subtract(const Duration(seconds: 60));
      final delay = fireAt.difference(DateTime.now());
      if (delay.isNegative) return;

      _refreshTimer = Timer(delay, () => _onCountdownFired(repo));
    });
  }

  Future<void> _onCountdownFired(AuthRepository repo) async {
    final user = await repo.tryRefresh();

    if (user == null) {
      state = const AsyncData(Unauthenticated());
      return;
    }

    state = AsyncData(Authenticated(user: user));
    _scheduleRefresh(repo);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncData(Authenticating());

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.login(email, password);

    switch (result) {
      case Success(data: final user):
        state = AsyncData(Authenticated(user: user));
        _scheduleRefresh(repo);
      case ServerFailure(message: final m):
        state = AsyncData(AuthError(m));
      case NetworkFailure(message: final m):
        state = AsyncData(AuthError(m));
      case UnknownFailure(message: final m):
        state = AsyncData(AuthError(m));
    }
  }

  Future<void> logout() async {
    _refreshTimer?.cancel();
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(Unauthenticated());
  }
}