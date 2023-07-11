import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/home_page.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/session_page.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/navigation_logger_observer.dart';
import 'package:ankigpt/src/providers/show_successful_playment_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final logger = ref.read(loggerProvider);
  return GoRouter(
    initialLocation: '/sessions/123',
    // initialLocation: '/',
    observers: [
      NavigationLoggerObserver(logger),
    ],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage2(),
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
            path: 'sucessful-plus-payment',
            redirect: (context, state) {
              ref.read(showSuccessfulPaymentDialogProvider.notifier).set(true);
              return '/';
            },
          ),
          GoRoute(
            path: 'sessions/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return SessionPage(sessionId: id);
            },
          ),
        ],
      ),
    ],
  );
}
