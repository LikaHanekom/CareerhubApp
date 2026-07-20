import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router/app_router.dart';
import 'core/isar_provider.dart';
import 'core/prefs_provider.dart';
import 'data/job_application_isar.dart';
import 'data/job_cache.dart';

void main() async {
  // Ensure engine bindings are ready for native plugins. This must be the
  // first statement: it creates the BinaryMessenger that Flutter's platform
  // channels use to talk to native code, and every plugin call below
  // (path_provider, shared_preferences, Isar's native bindings) goes through
  // it. Calling getApplicationDocumentsDirectory() before this line throws
  // a FlutterError: "Binding has not yet been initialized."
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch local document directory for Isar storage
  final dir = await getApplicationDocumentsDirectory();

  //  Open Isar with both collection schemas: existing application cache
  //  plus the new job cache added in this assignment.
  final isar = await Isar.open(
    [JobApplicationIsarSchema, JobCacheSchema],
    directory: dir.path,
  );

  //  Initialize shared preferences for filter state
  final sharedPrefs = await SharedPreferences.getInstance();

  // Run the app with runtime overrides injected into ProviderScope
  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        prefsProvider.overrideWithValue(sharedPrefs),
      ],
      child: const CareerHubApp(),
    ),
  );
}

class CareerHubApp extends ConsumerWidget {
  const CareerHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'CareerHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

