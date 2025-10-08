import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_loading_screen/custom_loading_screen.dart';

void main() {
  testWidgets('OverlayLoadingProgress shows and hides correctly',
      (WidgetTester tester) async {
    // Build a minimal app for testing
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Placeholder(),
        ),
      ),
    );

    final context = tester.element(find.byType(Placeholder));

    // Start the loading overlay
    OverlayLoadingProgress.start(
      context,
      loadingText: 'Loading changes. Please wait...',
    );

    // Wait a few frames for it to appear
    await tester.pump(const Duration(milliseconds: 500));

    // Verify loading overlay appears
    expect(find.text('Loading changes. Please wait...'), findsOneWidget);

    // Stop the loading overlay
    OverlayLoadingProgress.stop();

    // Wait a bit to let the overlay dismiss
    await tester.pump(const Duration(seconds: 1));

    // Verify it is removed
    expect(find.text('Loading changes. Please wait...'), findsNothing);
  });
}
