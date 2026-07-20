import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Placeholder — overridden in main.dart with a real [SharedPreferences]
/// instance before runApp(). Same reasoning as isarProvider: throw loudly
/// rather than silently degrade if something reads this before startup
/// finishes wiring the real instance in.
final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'prefsProvider has not been overridden. '
        'Override it with a real SharedPreferences instance in main.dart before runApp().',
  );
});
