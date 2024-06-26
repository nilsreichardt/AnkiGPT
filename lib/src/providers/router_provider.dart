import 'dart:async';

import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/deck_page.dart';
import 'package:ankigpt/src/pages/home_page.dart';
import 'package:ankigpt/src/pages/import_from_gpt_page/import_from_gpt_page.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/providers/analytics_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/navigation_logger_observer.dart';
import 'package:ankigpt/src/providers/show_successful_playment_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final logger = ref.read(loggerProvider);
  return GoRouter(
    observers: [
      NavigationLoggerObserver(logger),
    ],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final zero = state.uri.queryParameters['0'];
          final has0Analytics = zero?.isEmpty ?? false;
          return HomePage(has0Analytics: has0Analytics);
        },
        routes: [
          GoRoute(
            path: 'account',
            builder: (context, state) => const AccountPage(),
          ),
          GoRoute(
            path: 'imprint',
            builder: (context, state) => const ImprintPage(),
          ),
          GoRoute(
            path: 'successful-plus-payment',
            redirect: (context, state) {
              _logPlusBought(ref);
              ref.read(showSuccessfulPaymentDialogProvider.notifier).set(true);
              return '/';
            },
          ),
          GoRoute(
            path: 'cancel',
            redirect: (context, state) => '/',
          ),
          GoRoute(
            path: 'deck/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return DeckPage(sessionId: id);
            },
          ),
          GoRoute(
            path: 'import-from-gpt',
            builder: (context, state) {
              return const ImportFromGptPage();
            },
          ),
        ],
      ),
    ],
  );
}

void _logPlusBought(RouterRef ref) {
  final analytics = ref.read(analyticsProvider);
  unawaited(analytics.logEvent('plus_bought'));
}

Uri getCurrentLocation(Ref ref) {
  final router = ref.read(routerProvider);
  final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
  final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
      ? lastMatch.matches
      : router.routerDelegate.currentConfiguration;
  return matchList.uri;
}
