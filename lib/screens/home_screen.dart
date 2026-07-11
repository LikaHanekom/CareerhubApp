import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';
import '../providers/job_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<String> _filters = ['All', 'Remote', 'Full-time'];

  Widget _buildCard(BuildContext context, Job job) {
    return JobCard(job: job);
  }

  Widget _buildFilterChips(WidgetRef ref, String selectedFilter) {
    return SizedBox(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: _filters.map((label) {
            final isLast = label == _filters.last;
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : 8),
              child: FilterChip(
                label: Text(label),
                selected: selectedFilter == label,
                onSelected: (_) {
                  ref.read(selectedFilterProvider.notifier).state = label;
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildJobList(List<Job> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs match this filter.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: jobs.length,
            itemBuilder: (context, index) => _buildCard(context, jobs[index]),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: jobs.length,
          itemBuilder: (context, index) => _buildCard(context, jobs[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredJobsAsync = ref.watch(filteredJobsProvider);
    final selectedFilter = ref.watch(selectedFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('CareerHub')),
      body: Column(
        children: [
          _buildFilterChips(ref, selectedFilter),
          Expanded(
            child: filteredJobsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 8),
                    const Text('Something went wrong loading jobs.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(jobsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (jobs) => _buildJobList(jobs),
            ),
          ),
        ],
      ),
    );
  }
}
