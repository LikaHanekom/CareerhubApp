import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/prefs_provider.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  static const _storageKey = 'selected_filter';

  @override
  String build() {
    final prefs = ref.watch(prefsProvider);
    return prefs.getString(_storageKey) ?? 'All';
  }

  void select(String value) {
    final prefs = ref.read(prefsProvider);
    prefs.setString(_storageKey, value);
    state = value;
  }
}
