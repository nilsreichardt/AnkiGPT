import 'dart:async';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final devices = {
    iPhone8,
    iPhone13,
    iPadPro,
    desktop,
    pixel5,
  };
  AdaptiveTestConfiguration.instance
    ..setDeviceVariants(devices)
    ..setEnforcedTestPlatform(TargetPlatform.macOS);
  await loadFonts();
  setupFileComparatorWithThreshold(0.005);
  await testMain();
}
