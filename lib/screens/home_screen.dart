import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';
import '../widgets/offline_banner.dart';
import '../providers/job_providers.dart';
import '../providers/filter_notifier.dart';
import '../providers/connectivity_provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/jobs_notifier.dart';
import '../providers/saved_jobs_notifier.dart';
import '../providers/filtered_applications_provider.dart';
import '../providers/auth_notifier.dart';
import '../widgets/jobs_shimmer.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Stretch C (2.3): TextEditingController has a lifecycle, so it needs
  // ConsumerState (not a plain ConsumerWidget) to own and dispose it.
  // This is the ONLY reason HomeScreen remains a ConsumerStatefulWidget —
  // its build() method itself calls ref.watch zero times.
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _logout() {
    ref.invalidate(jobsProvider);
    ref.invalidate(savedJobsProvider);
    ref.invalidate(filteredApplicationsProvider);
    ref.read(authProvider.notifier).logout();
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search job titles...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) {
          // Callback context: read, not watch. Doesn't cause HomeScreen
          // to rebuild — the search field itself owns the controller.
          ref.read(searchQueryProvider.notifier).state = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // HomeScreen.build() now calls ref.watch zero times. Every piece of
    // UI that needs to react to a provider change lives in its own
    // private ConsumerWidget below, so a change to any single provider
    // only rebuilds the one widget that actually needs the new value.
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareerHub'),
        actions: [
          IconButton(
            tooltip: 'Refresh jobs',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(jobsProvider.notifier).refresh(),
          ),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _OfflineBannerArea(),
          _buildSearchField(),
          const SizedBox(height: 8),
          const _FilterChips(),
          const _SortToggle(),
          const SizedBox(height: 4),
          const Expanded(child: _JobList()),
        ],
      ),
    );
  }
}

/// Watches only isOfflineProvider. A connectivity change rebuilds just
/// this banner — the rest of the screen is untouched.
class _OfflineBannerArea extends ConsumerWidget {
  const _OfflineBannerArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineProvider);
    return OfflineBanner(
      isVisible: isOffline,
      message: "You're offline — showing cached jobs",
    );
  }
}

/// Watches only filterProvider. A filter chip tap rebuilds just this
/// row — the AppBar, search field, sort toggle, and job list are all
/// left alone by this widget (the job list rebuilds too, but because
/// it separately watches the filtered jobs provider, not because of
/// this widget).
class _FilterChips extends ConsumerWidget {
  const _FilterChips();

  static const List<String> _filters = ['All', 'Remote', 'Full-time'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(filterProvider);

    return SizedBox(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: _filters.map((label) {
            final isLast = label == _filters.last;
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : 8),
              child: FilterChip(
                label: Text(label),
                selected: selectedFilter == label,
                onSelected: (_) {
                  ref.read(filterProvider.notifier).select(label);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Watches only sortOrderProvider.
class _SortToggle extends ConsumerWidget {
  const _SortToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortOrder = ref.watch(sortOrderProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          const Text('Sort:'),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('A–Z'),
            selected: sortOrder == SortOrder.aToZ,
            onSelected: (_) {
              ref.read(sortOrderProvider.notifier).state = SortOrder.aToZ;
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Z–A'),
            selected: sortOrder == SortOrder.zToA,
            onSelected: (_) {
              ref.read(sortOrderProvider.notifier).state = SortOrder.zToA;
            },
          ),
        ],
      ),
    );
  }
}

/// Watches only visibleJobsProvider. A filter/sort/search change that
/// alters the visible job set rebuilds this widget (and only this
/// widget) — the AppBar, filter chips, and sort toggle above it are
/// untouched.
class _JobList extends ConsumerWidget {
  const _JobList();

  Widget _buildCard(BuildContext context, Job job) => JobCard(
    job: job,
    onTap: () => context.push('/jobs/${job.id}'),
  );

  Widget _buildJobListView(BuildContext context, List<Job> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs match this filter.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return RepaintBoundary(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.87,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: jobs.length,
              itemBuilder: (context, index) => _buildCard(context, jobs[index]),
            ),
          );
        }
        return RepaintBoundary(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: jobs.length,
            itemBuilder: (context, index) => _buildCard(context, jobs[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleJobsAsync = ref.watch(visibleJobsProvider);

    return visibleJobsAsync.when(
      loading: () => const JobsShimmer(),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 8),
            Text(
              err.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => ref.invalidate(jobsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (jobs) => _buildJobListView(context, jobs),
    );
  }
}
