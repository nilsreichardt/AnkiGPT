import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpAnkiGptApp({
  List<Override> overrides = const [],
  required WidgetTester tester,
  required Widget body,
  Widget? drawer,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: ankigptTheme,
        routes: {
          '/account': (context) => const AccountPage(),
        },
        home: Scaffold(
          drawer: drawer,
          body: body,
        ),
      ),
    ),
  );
}