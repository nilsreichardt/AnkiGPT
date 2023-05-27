import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../mocks/mock_url_launcher_platform.dart';

void main() {
  group('Footer', () {
    testWidgets('should open WhatsApp link when users click on feedback link',
        (tester) async {
      final mock = MockUrlLauncher();
      UrlLauncherPlatform.instance = mock;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Footer(releaseDate: 'June 1'),
          ),
        ),
      );

      mock
        ..setLaunchExpectations(
          url: 'https://wa.me/4915229504121',
          launchMode: PreferredLaunchMode.platformDefault,
          universalLinksOnly: false,
          enableJavaScript: true,
          enableDomStorage: true,
          headers: <String, String>{},
          webOnlyWindowName: null,
        )
        ..setResponse(true);

      final RichText textWidget = tester.widget(find.byType(RichText));
      final TextSpan span = textWidget.text as TextSpan;

      // Copied from https://github.com/flutter/packages/blob/main/packages/url_launcher/url_launcher/test/link_test.dart
      final List<Type> gestureRecognizerTypes = <Type>[];
      span.visitChildren((InlineSpan inlineSpan) {
        if (inlineSpan is TextSpan) {
          final TapGestureRecognizer? recognizer =
              inlineSpan.recognizer as TapGestureRecognizer?;
          gestureRecognizerTypes.add(recognizer?.runtimeType ?? Null);
          if (recognizer != null) {
            recognizer.onTap!();
          }
        }
        return true;
      });

      expect(mock.launchCalled, isTrue);
    });

    testGoldens('renders as excepcted', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            if (child == null) return const SizedBox();
            return Column(
              children: [
                Expanded(child: child),
                const Footer(releaseDate: 'June 1'),
              ],
            );
          },
          home: const Scaffold(),
        ),
      );
      await screenMatchesGolden(tester, 'footer');
    });
  });
}
