import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';

part 'saved_jobs_notifier.g.dart';

@riverpod
class SavedJobsNotifier extends _$SavedJobsNotifier {
  static const _storageKey = 'saved_job_ids';

  @override
  Set<String> build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final storedIds = prefs.getStringList(_storageKey);
    return storedIds == null ? {} : storedIds.toSet();
  }

  /// Adds the job if it isn't saved yet, removes it if it already is.
  void toggle(String jobId) {
    final prefs = ref.read(sharedPrefsProvider);
    final updated = {...state};

    if (updated.contains(jobId)) {
      updated.remove(jobId);
    } else {
      updated.add(jobId);
    }

    prefs.setStringList(_storageKey, updated.toList());
    state = updated;
  }

  bool isSaved(String jobId) => state.contains(jobId);
}
