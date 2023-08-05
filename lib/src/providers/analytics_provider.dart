import 'package:ankigpt/src/providers/plausible_provider.dart';
import 'package:plausible_analytics/plausible_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_provider.g.dart';

@riverpod
Analytics analytics(AnalyticsRef ref) {
  return Analytics(ref.watch(plausibleProvider));
}

class Analytics {
  final Plausible _plausible;

  const Analytics(this._plausible);

  Future<void> logEvent(
    String name, {
    Map<String, String>? params,
    String? page,
  }) async {
    _plausible.event(
      name: name,
      page: page ?? '',
      props: params ?? const {},
    );
  }
}
