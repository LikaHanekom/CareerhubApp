import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router/app_router.dart';
import 'data/job_application_isar.dart';


// Placeholder providers that require runtime overrides
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar has not been overridden');
});

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences has not been overridden');
});

void main() async {
  // Ensure engine bindings are ready for native plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch local document directory for Isar storage
  final dir = await getApplicationDocumentsDirectory();

  //  Open Isar with the job applications collection schema
  final isar = await Isar.open(
    [JobApplicationIsarSchema],
    directory: dir.path,
  );

  //  Initialize shared preferences for filter state
  final sharedPrefs = await SharedPreferences.getInstance();

  // Run the app with runtime overrides injected into ProviderScope
  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        sharedPrefsProvider.overrideWithValue(sharedPrefs),
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
