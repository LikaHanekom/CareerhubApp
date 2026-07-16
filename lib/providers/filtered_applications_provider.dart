import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/job_application.dart';
import 'applications_notifier.dart';
import 'applications_filter_notifier.dart';

part 'filtered_applications_provider.g.dart';

@riverpod
AsyncValue<List<JobApplication>> filteredApplications(FilteredApplicationsRef ref) {
  // Watch both upstream dependency layers
  final applicationsAsync = ref.watch(applicationsNotifierProvider);
  final activeFilter = ref.watch(applicationsFilterNotifierProvider);

  // Derive the final application layout collection strictly when values shift
  return applicationsAsync.whenData((applications) {
    if (activeFilter == null) {
      return applications; // Return everything if 'All' sentinel is active
    }

    // Perform exact subset matching against the active enum state
    return applications.where((app) => app.status == activeFilter).toList();
  });
}
