import 'package:flutter/material.dart';
import '../models/application_status.dart';

/// Maps every [ApplicationStatus] value to a distinct Material 3 colour
/// chip via a switch expression, so a missing case is a compile-time error.
class ApplicationStatusBadge extends StatelessWidget {
  final ApplicationStatus status;

  const ApplicationStatusBadge({
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (backgroundColor, textColor) = switch (status) {
      ApplicationStatus.pending => (
      colorScheme.secondaryContainer,
      colorScheme.onSecondaryContainer,
      ),
      ApplicationStatus.reviewed => (
      colorScheme.tertiaryContainer,
      colorScheme.onTertiaryContainer,
      ),
      ApplicationStatus.accepted => (
      colorScheme.primaryContainer,
      colorScheme.onPrimaryContainer,
      ),
      ApplicationStatus.rejected => (
      colorScheme.errorContainer,
      colorScheme.onErrorContainer,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.displayLabel,
        style: theme.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
