// Widget tests for CareerHub.
//
// Two structural changes since the router was added:
//
//  1. HomeScreen is no longer pumped directly as `home:` — it's reached by
//     routing to /jobs through MaterialApp.router. We pump CareerHubApp
//     itself (which owns the GoRouter) rather than wrapping HomeScreen in a
//     bare MaterialApp, since HomeScreen's card taps now depend on being
//     inside a Router (context.push needs a GoRouter ancestor).
//  2. initialLocation is '/jobs', and HomeScreen is the root builder for the
//     Jobs branch, so the app still lands on the jobs list with no extra
//     test setup — the loading/data assertions below are unchanged from
//     before the router was added.
//
// Window size note: _buildJobList's LayoutBuilder switches to a 2-column
// GridView at width >= 600, and both GridView.builder and ListView.builder
// only construct the items that fit in the current viewport (they're lazy).
// Adding the bottomNavigationBar shrank the vertical space available to the
// list, which meant only 2 of 4 cards were being built at the default
// 800x600 test window. Pinning a narrow, tall window keeps us on the
// ListView branch with enough height that all cards are actually built,
// regardless of what chrome (nav bar, etc.) is added around the list later.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:careerhub/main.dart';
import 'package:careerhub/widgets/job_card.dart';

Future<void> pumpCareerHubApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ProviderScope(child: CareerHubApp()));
}

void main() {
  testWidgets(
    'shows loading spinner, then renders job cards, status badges, and nav bar',
        (WidgetTester tester) async {
      await pumpCareerHubApp(tester);

      // Immediately after the first frame, jobsProvider is still loading.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Advance past the simulated Future.delayed in jobsProvider.
      await tester.pumpAndSettle();

      // Spinner gone, cards present.
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(JobCard), findsNWidgets(4));

      // Job titles render.
      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('Backend Engineer'), findsOneWidget);
      expect(find.text('UI Designer'), findsOneWidget);
      expect(find.text('QA Analyst'), findsOneWidget);

      // Status badges: all four sample jobs are isOpen: true.
      expect(find.text('Open'), findsNWidgets(4));
      expect(find.text('Closed'), findsNothing);

      // Filter chips render.
      expect(find.widgetWithText(FilterChip, 'All'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Remote'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Full-time'), findsOneWidget);

      // NavigationBar destinations.
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