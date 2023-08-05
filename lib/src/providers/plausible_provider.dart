import 'package:flutter/foundation.dart';
import 'package:plausible_analytics/plausible_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plausible_provider.g.dart';

@Riverpod(keepAlive: true)
Plausible plausible(PlausibleRef ref) {
  const serverUrl = 'https://plausible.io';
  const domain = 'ankigpt.help';

  final plausible = Plausible(serverUrl, domain);

  if (kDebugMode) {
    // Disable Plausible in debug mode to avoid skewing analytics.
    plausible.enabled = false;
  }

  return plausible;
}
