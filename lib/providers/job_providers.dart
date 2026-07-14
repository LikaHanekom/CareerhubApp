import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';
import 'jobs_notifier.dart';

/// Selected filter chip label.
final selectedFilterProvider = StateProvider<String>((ref) => 'All');

/// Stretch A — sort order, as its own independent piece of state.
enum SortOrder { aToZ, zToA }

final sortOrderProvider = StateProvider<SortOrder>((ref) => SortOrder.aToZ);

/// Stretch C — free-text search query.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered list — derived from the live jobs + filter only.
final filteredJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final jobsAsync = ref.watch(jobsNotifierProvider);
  final selectedFilter = ref.watch(selectedFilterProvider);

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