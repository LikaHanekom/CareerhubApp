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
    final result = await repository.getJobs();
    return switch (result) {
      Success(:final data) => data,//pattern that matches onlt when reult is success
      Failure(:final message) => throw Exception(message),
    };
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}