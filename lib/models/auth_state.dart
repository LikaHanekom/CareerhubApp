import 'user.dart';

/// The four states the app's auth flow can be in. A plain enum can't
/// express this: Authenticated needs to carry a User, AuthError needs to
/// carry a String, and the other two carry nothing at all — a sealed
/// class lets each subtype declare its own payload, so pattern matching
/// gets a compiler-guaranteed non-null value per case instead of a
/// shared nullable field every case has to tolerate.
sealed class AuthState {
  const AuthState();
}

/// No valid token found in storage. This is the initial state when
/// cold-boot's AuthNotifier.build() finds nothing to work with.
final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// A login attempt is in flight. Emitted only by login() — never by the
/// cold-boot check in build().
final class Authenticating extends AuthState {
  const Authenticating();
}

/// A valid, non-expired token exists, or login just succeeded.
final class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
}

/// Login failed — bad credentials or a network error.
final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}