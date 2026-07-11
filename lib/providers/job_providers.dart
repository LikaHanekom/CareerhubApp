import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';

// 1. The raw job list, loaded async with a simulated delay
final jobsProvider = FutureProvider<List<Job>>((ref) async {
  await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

  return [
    Job.remote(
      title: 'Flutter Developer',
      company: 'Kaya Digital',
      employmentType: 'Full-time',
      salary: 45000,
    ),
    Job(
      title: 'Backend Engineer',
      company: 'Nova Systems',
      location: 'Cape Town',
      employmentType: 'Full-time',
      isOpen: true,
      salary: 52000,
    ),
    Job.remote(
      title: 'UI Designer',
      company: 'Studio North',
      employmentType: 'Contract',
      salary: 38000,
    ),
    Job(
      title: 'QA Analyst',
      company: 'Kaya Digital',
      location: 'Johannesburg',
      employmentType: 'Full-time',
      isOpen: true,
      salary: 30000,
    ),
  ];
});

// 2. Selected filter label
final selectedFilterProvider = StateProvider<String>((ref) => 'All');

// 3. Derived, filtered list
final filteredJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  final selectedFilter = ref.watch(selectedFilterProvider);

  return jobsAsync.whenData((jobs) {
    if (selectedFilter == 'All') return jobs;

    return jobs.where((job) {
      return job.employmentType == selectedFilter ||
          job.location == selectedFilter;
    }).toList();
  });
});
