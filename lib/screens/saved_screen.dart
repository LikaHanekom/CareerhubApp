import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/job.dart';
import '../providers/job_providers.dart';
import '../providers/jobs_notifier.dart';
import '../widgets/job_card.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  Widget _buildList(BuildContext context, List<Job> jobs) {
    if (jobs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bookmark_border,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              const Text(
                'Jobs you save will show up here.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobCard(
          job: job,
          onTap: () => context.push('/jobs/${job.id}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedJobsAsync = ref.watch(savedJobsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs')),
      body: savedJobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 8),
                Text(
                  err.toString().replaceFirst('Exception: ', ''),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => ref.invalidate(jobsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (jobs) => _buildList(context, jobs),
      ),
    );
  }
}
