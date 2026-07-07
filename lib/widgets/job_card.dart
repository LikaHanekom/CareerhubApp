import 'package:flutter/material.dart';
import '../models/job.dart';

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
                Chip(
                  label: Text(job.canApply ? 'Open' : 'Closed'),
                  backgroundColor: job.canApply
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(job.company),
            Text(job.location),
            const SizedBox(height: 8),
            Text(job.displaySalary),
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