import 'package:flutter/material.dart';

class JobStatusBadge extends StatelessWidget {
  final bool isOpen;

  const JobStatusBadge({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Chip(
      label: Text(isOpen ? 'Open' : 'Closed'),
      backgroundColor: isOpen
          ? colorScheme.primaryContainer
          : colorScheme.errorContainer,
      labelStyle: TextStyle(
        color: isOpen
            ? colorScheme.onPrimaryContainer
            : colorScheme.onErrorContainer,
      ),
    );
  }
}