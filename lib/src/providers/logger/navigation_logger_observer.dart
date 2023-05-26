import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class NavigationLoggerObserver extends NavigatorObserver {
  NavigationLoggerObserver(this.logger);

  final Logger logger;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    logger.v('Router.didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    logger.v('Router.didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    logger.v('Router.didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    logger.v('Router.didReplace: ${newRoute?.settings.name}');
  }
}
