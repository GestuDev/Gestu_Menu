import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestu_menu/gestu_menu_primary_item.dart';
import 'package:gestu_menu/gestu_menu_secondary_item.dart';

void main() {
  testWidgets('GestuMenuPrimaryItem renders with title',
      (WidgetTester tester) async {
    // Define the widget
    const widget = MaterialApp(
      home: Scaffold(
        body: GestuMenuPrimaryItem(
          title: 'Primary Item',
          items: [],
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(widget);

    // Verify if the title is rendered
    expect(find.text('Primary Item'), findsOneWidget);
  });

  testWidgets('GestuMenuPrimaryItem expands and collapses',
      (WidgetTester tester) async {
    // Define the widget with children items
    const widget = MaterialApp(
      home: Scaffold(
        body: GestuMenuPrimaryItem(
          title: 'Primary Item',
          items: [
            Text('Secondary Item 1'),
            Text('Secondary Item 2'),
          ],
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(widget);

    // Verify the initial state (collapsed)
    expect(find.text('Secondary Item 1'), findsNothing);
    expect(find.text('Secondary Item 2'), findsNothing);

    // Tap to expand
    await tester.tap(find.text('Primary Item'));
    await tester.pumpAndSettle();

    // Verify the expanded state
    expect(find.text('Secondary Item 1'), findsOneWidget);
    expect(find.text('Secondary Item 2'), findsOneWidget);

    // Tap to collapse
    await tester.tap(find.text('Primary Item'));
    await tester.pumpAndSettle();

    // Verify the collapsed state
    expect(find.text('Secondary Item 1'), findsNothing);
    expect(find.text('Secondary Item 2'), findsNothing);
  });

  testWidgets('GestuMenuSecondaryItemWidget triggers onTap',
      (WidgetTester tester) async {
    // Define the callback variable
    bool wasTapped = false;

    // Define the widget
    final widget = MaterialApp(
      home: Scaffold(
        body: GestuMenuSecondaryItemWidget(
          title: 'Secondary Item',
          index: 1,
          onTap: (index) {
            wasTapped = true;
          },
        ),
      ),
    );

    // Build the widget
    await tester.pumpWidget(widget);

    // Tap the item
    await tester.tap(find.text('Secondary Item'));
    await tester.pumpAndSettle();

    // Verify the callback was triggered
    expect(wasTapped, isTrue);
  });
}
