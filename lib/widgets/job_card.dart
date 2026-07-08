import 'package:flutter/material.dart';
import '../models/job.dart';
import 'job_status_badge.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                JobStatusBadge(isOpen: job.canApply),
              ],
            ),
            const SizedBox(height: 4),
            Text(job.company, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )),
            Text(job.location, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(job.displaySalary, style: Theme.of(context).textTheme.bodyMedium),
            if (job.closingDate != null) ...[
              const SizedBox(height: 4),
              Text('Closes: ${job.closingDate!.toLocal().toString().split(' ').first}'),
            ],
            if (job.description != null) ...[
              const SizedBox(height: 8),
              Text(job.description!),
            ],
          ],
        ),
      ),
    );
  }
}