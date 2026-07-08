import 'package:flutter/material.dart';
import 'job_status_badge.dart';

class JobCardHeader extends StatelessWidget {
  final String title;
  final bool isOpen;

  const JobCardHeader({super.key, required this.title, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        JobStatusBadge(isOpen: isOpen),
      ],
    );
  }
}