import 'package:flutter/material.dart';

/// Slides in automatically when [isVisible] is true and disappears when
/// connectivity is restored. Requires no user interaction to show or hide.
class OfflineBanner extends StatelessWidget {
  final bool isVisible;
  final String message;

  const OfflineBanner({
    required this.isVisible,
    this.message = "You're offline — showing cached data",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      height: isVisible ? 36 : 0,
      width: double.infinity,
      color: colorScheme.errorContainer,
      clipBehavior: Clip.hardEdge,
      child: isVisible
          ? Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 16, color: colorScheme.onErrorContainer),
            const SizedBox(width: 8),
            Text(
              message,
              style: TextStyle(color: colorScheme.onErrorContainer, fontSize: 13),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
