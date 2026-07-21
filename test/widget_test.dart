// Widget tests for CareerHub.
//
// jobsNotifierProvider now calls a real HTTP API via Dio. There is no
// server available when `flutter test` runs, so this test overrides
// jobsNotifierProvider with a fake notifier that returns the same
// hardcoded jobs the assertions below have always checked against — no
// network call is made during the test run.
//
// Note on the fake notifier's class: `_$JobsNotifier` (the generated base
// class) is library-private — it's only visible inside jobs_notifier.dart
// and its .g.dart part file, not from this file. So the fake extends the
// public `JobsNotifier` class instead (which itself extends
// `_$JobsNotifier`), overriding build() the same way the real notifier
// does. This is the standard pattern for riverpod_generator overrides in
// tests.
//
// Auth override: AuthNotifier.build() reads the access token from
// FlutterSecureStorage, which has no platform channel backing in
// flutter_test — that read hangs indefinitely rather than throwing or
// resolving to null. Without an override, authNotifierProvider never
// leaves its loading state, so GoRouter's redirect callback (which
// returns null while loading) never fires either way. HomeScreen still
// happened to render underneath the unresolved future, but that's an
// accident of an unresolved Future, not a real authenticated state. This
// override makes the authenticated state explicit and instantaneous
// instead of relying on that hang being silently tolerated.
//
// Window size note: HomeScreen's LayoutBuilder switches to a 2-column
// GridView at width >= 600, and both GridView.builder and ListView.builder
// only build the items currently in the viewport. A narrow, tall window
// keeps the list on the single-column ListView branch with room for all
// cards to actually be built.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:careerhub/main.dart';
import 'package:careerhub/core/prefs_provider.dart';
import 'package:careerhub/models/job.dart';
import 'package:careerhub/models/user.dart';
import 'package:careerhub/models/auth_state.dart';
import 'package:careerhub/providers/jobs_notifier.dart';
import 'package:careerhub/providers/auth_notifier.dart';
import 'package:careerhub/widgets/job_card.dart';

class _FakeJobsNotifier extends JobsNotifier {
  @override
  Future<List<Job>> build() async {
    // Same delay as the original hardcoded provider, so the loading-state
    // assertion (spinner visible immediately after pump) still holds.
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    return [
      Job.remote(
        id: '1',
        title: 'Flutter Developer',
        company: 'Kaya Digital',
        employmentType: 'Full-time',
        salary: 45000,
      ),
      Job(
        id: '2',
        title: 'Backend Engineer',
        company: 'Nova Systems',
        location: 'Cape Town',
        employmentType: 'Full-time',
        isOpen: true,
        salary: 52000,
      ),
      Job.remote(
        id: '3',
        title: 'UI Designer',
        company: 'Studio North',
        employmentType: 'Contract',
        salary: 38000,
      ),
      Job(
        id: '4',
        title: 'QA Analyst',
        company: 'Kaya Digital',
        location: 'Johannesburg',
        employmentType: 'Full-time',
        isOpen: true,
        salary: 30000,
      ),
    ];
  }
}

class _FakeAuthNotifier extends AuthNotifier {
  @override
  Future<AuthState> build() async {
    // Resolve immediately as authenticated — no secure storage read, so
    // no hang, and no risk of GoRouter redirecting to /login mid-test.
    return const Authenticated(
      user: User(
        id: 'test-user-1',
        email: 'test@example.com',
        displayName: 'Test User',
      ),
    );
  }
}

Future<void> pumpCareerHubApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  // Assignment 2.3: HomeScreen now reads filterProvider, whose build()
  // reads prefsProvider. prefsProvider throws UnimplementedError unless
  // overridden, so this test needs a real (mocked) SharedPreferences
  // instance, same as production main.dart wires up — just backed by an
  // in-memory mock instead of the platform channel.
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        jobsProvider.overrideWith(() => _FakeJobsNotifier()),
        prefsProvider.overrideWithValue(prefs),
        authProvider.overrideWith(() => _FakeAuthNotifier()),
      ],
      child: const CareerHubApp(),
    ),
  );
}

void main() {
  testWidgets(
    'shows loading spinner, then renders job cards, status badges, and nav bar',
        (WidgetTester tester) async {
      await pumpCareerHubApp(tester);

      // Immediately after the first frame, the fake notifier is still
      // "loading" — no network call, but the same artificial delay.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(JobCard), findsNWidgets(4));

      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('Backend Engineer'), findsOneWidget);
      expect(find.text('UI Designer'), findsOneWidget);
      expect(find.text('QA Analyst'), findsOneWidget);

      expect(find.text('Open'), findsNWidgets(4));
      expect(find.text('Closed'), findsNothing);

      expect(find.widgetWithText(FilterChip, 'All'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Remote'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Full-time'), findsOneWidget);

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.widgetWithText(NavigationDestination, 'Jobs'), findsOneWidget);
      expect(find.widgetWithText(NavigationDestination, 'Saved'), findsOneWidget);
    },
  );

  testWidgets(
    'tapping the Remote filter chip narrows the job list',
        (WidgetTester tester) async {
      await pumpCareerHubApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Remote'));
      await tester.pump();

      expect(find.byType(JobCard), findsNWidgets(2));
      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('UI Designer'), findsOneWidget);
      expect(find.text('Backend Engineer'), findsNothing);
      expect(find.text('QA Analyst'), findsNothing);
    },
  );

  testWidgets(
    'tapping All after a filter restores the full job list',
        (WidgetTester tester) async {
      await pumpCareerHubApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Full-time'));
      await tester.pump();
      expect(find.byType(JobCard), findsNWidgets(3));

      await tester.tap(find.widgetWithText(FilterChip, 'All'));
      await tester.pump();
      expect(find.byType(JobCard), findsNWidgets(4));
    },
  );

  testWidgets(
    'tapping a job card navigates to its detail screen by id',
        (WidgetTester tester) async {
      await pumpCareerHubApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backend Engineer').first);
      await tester.pumpAndSettle();

      expect(find.text('Job Details'), findsOneWidget);
      expect(find.text('Nova Systems'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    },
  );
}