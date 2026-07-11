// Widget tests for CareerHub's HomeScreen.
//
// HomeScreen is now a ConsumerWidget backed by Riverpod providers, and its
// job list loads asynchronously with a simulated network delay. Both facts
// changed how this test has to be written compared to the original
// StatelessWidget + static-list version:
//
//  1. ConsumerWidget requires a ProviderScope ancestor to resolve providers,
//     so every pumped widget tree below must be wrapped in one.
//  2. The job list is `loading` for ~1.5s after the first frame, so a single
//     tester.pump() is not enough to reach the data state — we must advance
//     time with pumpAndSettle() before asserting on job cards.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:careerhub/screens/home_screen.dart';
import 'package:careerhub/widgets/job_card.dart';

void main() {
  testWidgets(
    'shows loading spinner, then renders job cards with status badges',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      // Fix for failure mode 2 (async loading): immediately after the first
      // frame, jobsProvider is still in its loading state.
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

      // Fit (filter) chips render.
      expect(find.widgetWithText(FilterChip, 'All'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Remote'), findsOneWidget);
      expect(find.widgetWithText(FilterChip, 'Full-time'), findsOneWidget);
    },
  );

  testWidgets(
    'tapping the Remote filter chip narrows the job list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Remote'));
      await tester.pump(); // filter update is synchronous, no delay to wait out

      // Flutter Developer and UI Designer are the two Job.remote() entries.
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
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Full-time'));
      await tester.pump();
      expect(find.byType(JobCard), findsNWidgets(3));

      await tester.tap(find.widgetWithText(FilterChip, 'All'));
      await tester.pump();
      expect(find.byType(JobCard), findsNWidgets(4));
    },
  );
}
