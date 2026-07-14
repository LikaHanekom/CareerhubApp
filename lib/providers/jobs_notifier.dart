import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/jobs_repository.dart';
import '../models/job.dart';

part 'jobs_notifier.g.dart';

@riverpod
class JobsNotifier extends _$JobsNotifier {
  @override
  Future<List<Job>> build() async {
    final repository = ref.read(jobsRepositoryProvider);
    return repository.getJobs();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}