import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/api_result.dart';
import '../data/auth_repository.dart';
import '../models/auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    // ref.read, not ref.watch: this repository doesn't change identity
    // during the notifier's lifetime, and watching it here would just
    // add a rebuild dependency this method doesn't need.
    final repository = ref.read(authRepositoryProvider);

    final token = await repository.readAccessToken();
    if (token == null) return const Unauthenticated();

    if (repository.isTokenExpired(token)) {
      // This backend has no refresh endpoint (see auth_repository.dart),
      // so tryRefresh() always resolves to null here — but the call
      // stays in place so build() doesn't need to change the day a real
      // refresh flow exists server-side.
      final user = await repository.tryRefresh();
      return user != null ? Authenticated(user: user) : const Unauthenticated();
    }

    return Authenticated(user: repository.decodeUser(token));
  }

  Future<void> login(String username, String password) async {
    // Set before any await: LoginScreen watches this to show its
    // loading spinner the instant the button is tapped, not after the
    // network call resolves.
    state = const AsyncData(Authenticating());

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.login(username, password);

    state = switch (result) {
      Success(:final data) => AsyncData(Authenticated(user: data)),
      NetworkFailure(:final message) ||
      ServerFailure(:final message) ||
      UnknownFailure(:final message) =>
          AsyncData(AuthError(message)),
    };
  }

  // Deliberately does not import or reference jobs_notifier.dart or any
  // other data notifier — invalidating user-specific data providers is
  // the caller's responsibility (the logout button, in Part 9), not
  // this notifier's. Reaching into a specific feature's provider from
  // here would create the circular import chain described in the
  // README's Part 1 Q4 answer.
  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AsyncData(Unauthenticated());
  }
}