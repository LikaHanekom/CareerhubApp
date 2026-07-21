import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import 'auth_notifier.dart';

/// Exists solely to break the circular import that would form if
/// auth_interceptor.dart (data layer, zero Riverpod imports) needed to
/// import auth_notifier.dart directly. AuthInterceptor is handed this
/// closure instead — it can call it without knowing anything about
/// Riverpod or providers.
///
/// When the interceptor calls this after a failed refresh, invalidating
/// authNotifierProvider forces its build() to run again. With storage
/// now cleared, it finds nothing and returns Unauthenticated — which
/// the router's redirect callback (Part 8) picks up to send the user to
/// the login screen.
final onUnauthenticatedProvider = Provider<void Function()>((ref) {
  return () => ref.invalidate(authProvider);
});

/// Bridges Riverpod's authNotifierProvider to GoRouter's
/// refreshListenable, which expects a plain ChangeNotifier, not a
/// Riverpod provider. Every time authNotifierProvider's value changes,
/// this calls notifyListeners() so GoRouter knows to re-run its
/// redirect callback.
class AuthStateListenable extends ChangeNotifier {
  late final ProviderSubscription<AsyncValue<AuthState>> _subscription;

  AuthStateListenable(Ref ref) {
    _subscription = ref.listen(
      authProvider,
          (previous, next) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

final authStateListenableProvider = Provider<AuthStateListenable>((ref) {
  final listenable = AuthStateListenable(ref);
  ref.onDispose(listenable.dispose);
  return listenable;
});