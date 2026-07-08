import 'package:flutter/material.dart';

class JobStatusBadge extends StatelessWidget {
  final bool isOpen;

  const JobStatusBadge({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(isOpen ? 'Open' : 'Closed'),
      backgroundColor: isOpen ? Colors.green.shade100 : Colors.red.shade100,
    );
  }
}