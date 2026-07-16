import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/application_status.dart';
import '../models/job_application.dart';
import '../providers/applications_filter_notifier.dart';
import '../providers/applications_notifier.dart';
import '../providers/filtered_applications_provider.dart';
import '../providers';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the derived filtered provider
    final filteredAppsAsync = ref.watch(filteredApplicationsProvider);
    final activeFilter = ref.watch(applicationsFilterNotifierProvider);

    // Reactive connectivity stream monitoring
    final isOnlineAsync = ref.watch(isOnlineProvider);
    final isOnline = isOnlineAsync.value ?? true;

    final mediaQuery = MediaQuery.of(context);
    final isWideScreen = mediaQuery.size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        // Horizontally scrollable row of filter chips
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: activeFilter == null,
                  onSelected: (_) => ref
                      .read(applicationsFilterNotifierProvider.notifier)
                      .setFilter(null),
                ),
                const SizedBox(width: 8),
                ...ApplicationStatus.values.map((status) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(status.displayLabel),
                      selected: activeFilter == status,
                      onSelected: (_) => ref
                          .read(applicationsFilterNotifierProvider.notifier)
                          .setFilter(status),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Automated network banner with zero interaction required(Offline Banner)
          AnimatedVisibilityBanner(isVisible: !isOnline),

          Expanded(
            child: filteredAppsAsync.when(
              // Render the list
              data: (applications) {
                if (applications.isEmpty) {
                  return const Center(
                    child: Text('No applications found.'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(applicationsNotifierProvider.notifier)
                      .refresh(),
                  // Responsive layout builder configuration
                  child: isWideScreen
                      ? GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 110,
                          ),
                          itemCount: applications.length,
                          itemBuilder: (context, index) => ApplicationCard(
                            application: applications[index],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: applications.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ApplicationCard(
                              application: applications[index],
                            ),
                          ),
                        ),
                );
              },
              // Clear error message and a retry button during network failure
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load applications:\n${err.toString()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry Loading'),
                        onPressed: () => ref
                            .read(applicationsNotifierProvider.notifier)
                            .refresh(),
                      ),
                    ],
                  ),
                ),
              ),
              // CircularProgressIndicator during loading state
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom isolated ApplicationCard widget
class ApplicationCard extends StatelessWidget {
  final JobApplication application;

  const ApplicationCard({
    required this.application,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Basic human-readable date formatting split execution
    final dateString = application.dateApplied.toLocal().toString().split(' ')[0];

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

//  Custom strict exhaustiveness-checked ApplicationStatusBadge widget
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

    // Strict Dart switch expression mapping to Material 3 Roles.
    final (backgroundColor, textColor) = switch (status) {
      ApplicationStatus.pending => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer
        ),
      ApplicationStatus.reviewed => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer
        ),
      ApplicationStatus.accepted => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer
        ),
      ApplicationStatus.rejected => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer
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

// Helper widget to slide/animate the connectivity warning banner safely
class AnimatedVisibilityBanner extends StatelessWidget {
  final bool isVisible;
  final Widget child;

  const AnimatedVisibilityBanner({
    required this.isVisible,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      height: isVisible ? 40 : 0,
      color: Theme.of(context).colorScheme.error,
      child: ClipRect(
        child: Visibility(
          visible: isVisible,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: child,
          ),
        ),
      ),
    );
  }
}