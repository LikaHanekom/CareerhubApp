import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';
import 'jobs_notifier.dart';
import 'saved_jobs_notifier.dart';
import 'filter_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Stretch A — sort order, as its own independent piece of state.
enum SortOrder { aToZ, zToA }

final sortOrderProvider = StateProvider<SortOrder>((ref) => SortOrder.aToZ);

/// Stretch C — free-text search query.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered list — derived from the live jobs + filter only.
final filteredJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  final selectedFilter = ref.watch(filterProvider);

  return jobsAsync.whenData((jobs) {
    if (selectedFilter == 'All') return jobs;
    return jobs
        .where((job) =>
    job.employmentType == selectedFilter ||
        job.location == selectedFilter)
        .toList();
  });
});

/// Filtered + searched — derived from [filteredJobsProvider] + search query.
final searchedJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final filteredAsync = ref.watch(filteredJobsProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return filteredAsync.whenData((jobs) {
    if (query.isEmpty) return jobs;
    return jobs.where((job) => job.title.toLowerCase().contains(query)).toList();
  });
});

/// Filtered + searched + sorted — the ONLY data provider HomeScreen watches.
final visibleJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final searchedAsync = ref.watch(searchedJobsProvider);
  final sortOrder = ref.watch(sortOrderProvider);

  return searchedAsync.whenData((jobs) {
    final sorted = [...jobs];
    sorted.sort((a, b) => sortOrder == SortOrder.aToZ
        ? a.title.compareTo(b.title)
        : b.title.compareTo(a.title));
    return sorted;
  });
});

/// Jobs the user has bookmarked — derived from the raw job list + the
/// persisted set of saved job IDs. Deliberately built off [jobsProvider]
/// (not [visibleJobsProvider]), since a saved job should still show up here
/// even if it wouldn't currently match the home screen's filter/search/sort.
final savedJobsListProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  final savedIds = ref.watch(savedJobsProvider);

  return jobsAsync.whenData((jobs) {
    return jobs.where((job) => savedIds.contains(job.id)).toList();
  });
});