import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

/// Placeholder — overridden in main.dart with a real, opened [Isar] instance
/// before runApp(). Throwing here (instead of returning null or a default)
/// means any code path that reads this provider without the override in
/// place fails loudly and immediately, rather than silently operating on
/// no database.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider has not been overridden. '
        'Override it with a real Isar instance in main.dart before runApp().',
  );
});
