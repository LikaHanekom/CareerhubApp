import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:careerhub/models/job_application.dart';
import 'package:careerhub/data/applications_repository_provider.dart';

part 'applications_notifier.g.dart';

@riverpod
class ApplicationsNotifier extends _$ApplicationsNotifier {
  @override
  Future<List<JobApplication>> build() async {
    final repository = ref.watch(applicationsRepositoryProvider);

    // Read the Isar cache
    final cachedData = repository.getCachedApplications();

    // If cached data exists, push it to the state immediately
    if (cachedData.isNotEmpty) {
      state = AsyncData(cachedData);
    }

    // Initiate the live network call in the background
    final result = await repository.fetchAndCacheApplications();

    return result.when(
      success: (freshApplications) {
        // Return live data on success
        return freshApplications;
      },
      failure: (message, statusCode) {
        // Fallback on network failure: if cache has items, show them, don't crash
        if (cachedData.isNotEmpty) {
          return cachedData;
        }
        // If cache is completely dry and network fails, throw the error down to the UI
        throw Exception(message);
      },
    );
  }

  /// Call this from the UI to manually refresh data
  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
