import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Future<void> pumpAnkiGptApp({
  List<Override> overrides = const [],
  required WidgetTester tester,
  required Widget body,
  Widget? drawer,
  WindowConfigData? variant,
}) async {
  Widget app = ProviderScope(
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
  );

  if (variant != null) {
    app = AdaptiveWrapper(
      tester: tester,
      windowConfig: variant,
      child: app,
    );
  }

  await tester.pumpWidget(app);
}

Future<void> pumpAnkiGptAppWithRouter({
  List<Override> overrides = const [],
  required WidgetTester tester,
  required GoRouter router,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(
        routerConfig: router,
        theme: ankigptTheme,
      ),
    ),
  );
}
