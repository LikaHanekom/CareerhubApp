import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//wrap in ProvideScope
void main() => runApp(const ProviderScope(child : CareerHubApp()));

class CareerHubApp extends StatelessWidget {
  const CareerHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomeScreen(),
    );
  }
}

