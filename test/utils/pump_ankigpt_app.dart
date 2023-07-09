import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpAnkiGptApp({
  List<Override> overrides = const [],
  required WidgetTester tester,
  required Widget body,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: ankigptTheme,
        home: Scaffold(
          body: body,
        ),
      ),
    ),
  );
}
