import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wiredash/wiredash.dart';

part 'analytics_provider.g.dart';

@riverpod
Analytics analytics(AnalyticsRef ref) {
  return const Analytics();
}

class Analytics {
  const Analytics();

  Future<void> logEvent(
    String name, {
    Map<String, String>? params,
    String? page,
  }) async {
    await Wiredash.trackEvent(name, data: {
      if (params != null) 'params': params,
      if (page != null) 'page': page,
    });
  }
}
