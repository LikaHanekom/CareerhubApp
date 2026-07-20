import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/jobs_repository.dart';
import '../models/job.dart';
import '../data/api_result.dart';

part 'jobs_notifier.g.dart';

@riverpod
class JobsNotifier extends _$JobsNotifier {
  @override
  Future<List<Job>> build() async {
    final repository = ref.read(jobsRepositoryProvider);

    // 1. Read whatever's cached first, with zero network latency.
    final cachedJobs = await repository.getCachedJobs();

    // 2. If there's cached data, push it to the UI immediately.
    if (cachedJobs.isNotEmpty) {
      state = AsyncData(cachedJobs);
    }

    // 3. Attempt the live network call.
    final result = await repository.getJobs();

    return switch (result) {
      Success(:final data) => data,
      NetworkFailure(:final message) ||
      ServerFailure(:final message) ||
      UnknownFailure(:final message) =>
      cachedJobs.isNotEmpty ? cachedJobs : throw Exception(message),
    };
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
