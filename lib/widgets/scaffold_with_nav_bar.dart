import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final onDetailScreen = RegExp(r'^/jobs/[^/]+$').hasMatch(location);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: onDetailScreen
          ? null
          : NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // Tapping the already-active tab resets that branch's
            // stack back to its root instead of doing nothing.
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}