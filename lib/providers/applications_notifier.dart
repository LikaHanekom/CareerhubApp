import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/api_result.dart';
import '../data/application_repository.dart';
import '../models/job_application.dart';
import '../models/job.dart';

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

    return switch (result) {
      Success(:final data) => data,
    // Fallback on any network failure: if cache has items, show them
    // instead of throwing. If the cache is dry, surface the error to
    // the UI.
      NetworkFailure(:final message) ||
      ServerFailure(:final message) ||
      UnknownFailure(:final message) =>
      cachedData.isNotEmpty ? cachedData : throw Exception(message),
    };
  }

  /// Call this from the UI to manually refresh data
  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }

  /// Submits an application, then refetches the full list on success so
  /// the new row shows up using the exact same GET → mapper pipeline as
  /// everything else — no guessing at the POST response shape.
  Future<void> apply({
    required Job job,
    required String fullName,
    required String email,
    String? phone,
    required int yearsOfExperience,
    required String coverLetter,
    String? linkedInUrl,
    required bool availableImmediately,
    required int noticePeriodWeeks,
  }) async {
    final repository = ref.read(applicationsRepositoryProvider);
    final result = await repository.applyToJob(
      job: job,
      fullName: fullName,
      email: email,
      phone: phone,
      yearsOfExperience: yearsOfExperience,
      coverLetter: coverLetter,
      linkedInUrl: linkedInUrl,
      availableImmediately: availableImmediately,
      noticePeriodWeeks: noticePeriodWeeks,
    );

    switch (result) {
      case Success():
        await refresh();
      case NetworkFailure(:final message) ||
      ServerFailure(:final message) ||
      UnknownFailure(:final message):
        throw Exception(message);
    }
  }
}

