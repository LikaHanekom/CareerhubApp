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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const List<String> _filters = ['All', 'Remote', 'Full-time'];

  // Stretch C: TextEditingController has a lifecycle, so it needs
  // ConsumerState (not a plain ConsumerWidget) to own and dispose it.
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

  Widget _buildCard(BuildContext context, Job job) => JobCard(
    job: job,
    onTap: () => context.push('/jobs/${job.id}'),
  );

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
          // Callback context: read, not watch.
          ref.read(searchQueryProvider.notifier).state = value;
        },
      ),
    );
  }

  Widget _buildFilterChips(String selectedFilter) {
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

  Widget _buildSortToggle(SortOrder sortOrder) {
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

  Widget _buildJobList(List<Job> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs match this filter.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: jobs.length,
            itemBuilder: (context, index) => _buildCard(context, jobs[index]),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: jobs.length,
          itemBuilder: (context, index) => _buildCard(context, jobs[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // HomeScreen watches exactly ONE data provider (visibleJobsProvider),
    // a few small "which option is selected" providers used only to drive
    // chip/toggle highlighting, and isOfflineProvider for the banner. It
    // has no idea filtering, searching, and sorting are three separate
    // steps under the hood.
    final visibleJobsAsync = ref.watch(visibleJobsProvider);
    final selectedFilter = ref.watch(filterProvider);
    final sortOrder = ref.watch(sortOrderProvider);
    final isOffline = ref.watch(isOfflineProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CareerHub'),
        actions: [
          IconButton(
            tooltip: 'Refresh jobs',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(jobsProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          OfflineBanner(
            isVisible: isOffline,
            message: "You're offline — showing cached jobs",
          ),
          _buildSearchField(),
          const SizedBox(height: 8),
          _buildFilterChips(selectedFilter),
          _buildSortToggle(sortOrder),
          const SizedBox(height: 4),
          Expanded(
            child: visibleJobsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
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
              data: (jobs) => _buildJobList(jobs),
            ),
          ),
        ],
      ),
    );
  }
}
