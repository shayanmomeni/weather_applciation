import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/components/switch_btn_widget.dart';
import 'package:weather_application/core/constants/config.dart';

void main() {
  testWidgets('AppSwitchButton displays correctly',
      (WidgetTester tester) async {
    bool switchValue = false;
    final primaryColor = AppConfig().colors.primaryColor;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSwitchButton(
            value: switchValue,
            onChanged: (newValue) {
              switchValue = newValue;
            },
          ),
        ),
      ),
    );

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    final switchWidget = tester.widget<Switch>(switchFinder);
    expect(switchWidget.value, switchValue);
    expect(switchWidget.activeColor, primaryColor);
    expect(switchWidget.inactiveTrackColor, Colors.white);
    expect(switchWidget.activeTrackColor, primaryColor);
  });

  testWidgets('AppSwitchButton onChanged callback works',
      (WidgetTester tester) async {
    bool switchValue = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppSwitchButton(
            value: switchValue,
            onChanged: (newValue) {
              switchValue = newValue;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(switchValue, true);
  });
}
