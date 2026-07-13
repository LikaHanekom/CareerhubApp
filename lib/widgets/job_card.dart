import 'package:flutter/material.dart';
import '../models/job.dart';
import 'job_status_badge.dart';
import 'job_card_header.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;

  const JobCard({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobCardHeader(title: job.title, isOpen: job.canApply),
              const SizedBox(height: 4),
              Text(
                job.company,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              Text(job.location, style: textTheme.bodySmall),
              const SizedBox(height: 8),
              Text(job.displaySalary, style: textTheme.bodyMedium),
              if (job.closingDate != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Closes: ${job.closingDate!.toLocal().toString().split(' ').first}',
                  style: textTheme.bodySmall,
                ),
              ],
              if (job.description != null) ...[
                const SizedBox(height: 8),
                Text(job.description!, style: textTheme.bodyMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }
}