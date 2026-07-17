import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Raw OS connectivity stream. Seeded with the current status via
/// [Connectivity.checkConnectivity] before forwarding [onConnectivityChanged],
/// so the UI has an answer immediately instead of waiting for the first
/// change event (which never fires if the app starts offline).
final connectivityStreamProvider =
StreamProvider<List<ConnectivityResult>>((ref) async* {
  final connectivity = Connectivity();
  yield await connectivity.checkConnectivity();
  yield* connectivity.onConnectivityChanged;
});

/// Derived, UI-friendly boolean: true when at least one active connection
/// type is reported. Defaults to true (online) while the first reading is
/// still in flight, so we don't flash an offline banner on cold start.
final isOnlineProvider = Provider<bool>((ref) {
  final results = ref.watch(connectivityStreamProvider).value;
  if (results == null) return true;
  return results.any((result) => result != ConnectivityResult.none);
});
