import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/job.dart';
import '../providers/jobs_notifier.dart';
import '../providers/saved_jobs_notifier.dart';

class JobDetailScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the RAW jobs provider, not visibleJobsProvider: this screen can
    // be reached by a direct URL (deep link, notification tap, or typing
    // /jobs/3) with no guarantee the current filter/search/sort state
    // includes this job — the raw list is the only one guaranteed to.
    final jobsAsync = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(err.toString().replaceFirst('Exception: ', '')),
        ),
        data: (jobs) {
          Job? job;
          for (final j in jobs) {
            if (j.id == jobId) {
              job = j;
              break;
            }
          }

          if (job == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 48),
                  const SizedBox(height: 8),
                  Text('No job found with id "$jobId".'),
                ],
              ),
            );
          }

          return _JobDetailBody(job: job);
        },
      ),
    );
  }
}


class _JobDetailBody extends ConsumerWidget {
  final Job job;
  const _JobDetailBody({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedIds = ref.watch(savedJobsProvider);
    final isSaved = savedIds.contains(job.id);

    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(job.title, style: textTheme.headlineSmall),
            ),
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: () {
                ref.read(savedJobsProvider.notifier).toggle(job.id);
              },
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(job.company, style: textTheme.titleMedium),
        const SizedBox(height: 12),
        _DetailRow(label: 'Location', value: job.location),
        _DetailRow(label: 'Employment type', value: job.employmentType),
        _DetailRow(label: 'Salary', value: job.displaySalary),
        _DetailRow(label: 'Status', value: job.isOpen ? 'Open' : 'Closed'),
        if (job.closingDate != null)
          _DetailRow(
            label: 'Closing date',
            value: job.closingDate!.toLocal().toString().split(' ').first,
          ),
        if (job.description != null) ...[
          const SizedBox(height: 16),
          Text('Description', style: textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(job.description!),
        ],
        const SizedBox(height: 24),
        FilledButton(
          onPressed: job.canApply
              ? () => context.push('/jobs/${job.id}/apply')
              : null,
          child: Text(job.canApply ? 'Apply now' : 'Applications closed'),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
