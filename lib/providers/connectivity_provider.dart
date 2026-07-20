import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Connectivity _connectivity = Connectivity();

final connectivityStreamProvider =
StreamProvider<List<ConnectivityResult>>((ref) {
  return _connectivity.onConnectivityChanged;
});

final isOfflineProvider = Provider<bool>((ref) {
  final connectivityAsync = ref.watch(connectivityStreamProvider);

  return connectivityAsync.when(
    data: (results) => results.every((r) => r == ConnectivityResult.none),
    loading: () => false,
    error: (err, stack) => false,
  );
});
