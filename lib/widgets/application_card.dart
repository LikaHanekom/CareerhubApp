import 'package:flutter/material.dart';
import '../models/job_application.dart';
import 'application_status_badge.dart';

/// Displays a single [JobApplication]. Receives all data from its parent -
/// it never watches Riverpod providers directly.
class ApplicationCard extends StatelessWidget {
  final JobApplication application;

  const ApplicationCard({
    required this.application,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateString =
    application.dateApplied.toLocal().toString().split(' ')[0];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    application.jobTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    application.company,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Applied: $dateString',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ApplicationStatusBadge(status: application.status),
          ],
        ),
      ),
    );
  }
}
