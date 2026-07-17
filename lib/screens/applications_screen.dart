import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/application_status.dart';
import '../providers/applications_filter_notifier.dart';
import '../providers/applications_notifier.dart';
import '../providers/connectivity_provider.dart';
import '../providers/filtered_applications_provider.dart';
import '../widgets/application_card.dart';
import '../widgets/offline_banner.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the derived filtered provider
    final filteredAppsAsync = ref.watch(filteredApplicationsProvider);
    final activeFilter = ref.watch(applicationsFilterProvider);

    // Reactive connectivity monitoring - no polling, no Timer
    final isOnline = ref.watch(isOnlineProvider);

    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;

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
                      .read(applicationsFilterProvider.notifier)
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
                          .read(applicationsFilterProvider.notifier)
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
          // Automated network banner, zero interaction required
          OfflineBanner(isVisible: !isOnline),

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
                      .read(applicationsProvider.notifier)
                      .refresh(),
                  // Responsive layout: single column below 600px, grid above
                  child: isWideScreen
                      ? GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 48),
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
                            .read(applicationsProvider.notifier)
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
