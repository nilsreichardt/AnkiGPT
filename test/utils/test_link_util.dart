import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../mocks/mock_url_launcher_platform.dart';

/// A helper function to test links.
Future<void> testLink({
  required Future<void> Function(WidgetTester tester) pumpWidget,
  required WidgetTester tester,
  required Finder find,
  required String uri,
  String? webOnlyWindowName,
}) async {
  final mock = MockUrlLauncher();
  UrlLauncherPlatform.instance = mock;
  mock.setLaunchExpectations(
    url: uri,
    webOnlyWindowName: webOnlyWindowName,
  );

  await pumpWidget(tester);

  await tester.tap(find);
  expect(mock.launchCalled, isTrue);
}
