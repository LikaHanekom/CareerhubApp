import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/job_detail_screen.dart';
import '../screens/saved_screen.dart';
import '../widgets/scaffold_with_nav_bar.dart';
import '../screens/applications_screen.dart';
import '../screens/login_screen.dart';
import '../models/auth_state.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_provider.dart';
import '../screens/register_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authListenable = ref.watch(authStateListenableProvider);

  return GoRouter(
    initialLocation: '/jobs',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authValue = ref.read(authProvider);

      // Cold-boot check still running -> don't redirect yet.
      if (authValue.isLoading) return null;

      final authState = authValue.asData?.value;
      final isAuthenticated = authState is Authenticated;
      final isOnAuthFlow = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuthenticated && !isOnAuthFlow) return '/login';
      if (isAuthenticated && isOnAuthFlow) return '/jobs';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/jobs',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return JobDetailScreen(jobId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/saved',
                builder: (context, state) => const SavedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/applications',
                builder: (context, state) => const ApplicationsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}