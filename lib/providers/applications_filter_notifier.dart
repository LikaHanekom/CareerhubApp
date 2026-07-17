import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/application_status.dart';
import '../main.dart';
part 'applications_filter_notifier.g.dart';


@riverpod
class ApplicationsFilterNotifier extends _$ApplicationsFilterNotifier {
  static const _storageKey = 'selected_application_filter';

  @override
  ApplicationStatus? build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final savedFilterName = prefs.getString(_storageKey);

    if (savedFilterName == null) return null; // Default to All

    // Safe matching from persisted string back to application status enum values
    return ApplicationStatus.values.firstWhereOrNull(
          (status) => status.name == savedFilterName,
    );
  }

  /// Updates the application status filter slice and updates SharedPreferences synchronously
  void setFilter(ApplicationStatus? newStatus) {
    final prefs = ref.read(sharedPrefsProvider);

    if (newStatus == null) {
      prefs.remove(_storageKey);
    } else {
      prefs.setString(_storageKey, newStatus.name);
    }

    state = newStatus;
  }
}

