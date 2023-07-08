import 'package:ankigpt/src/pages/widgets/social_media_icon_button.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_link_util.dart';

void main() {
  group(SocialMediaIconButton, () {
    Future<void> pumpIcon(
      WidgetTester tester, {
      required String url,
      required SocialMediaPlatform platform,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ankigptTheme,
          home: Scaffold(
            body: Row(
              children: [
                SocialMediaIconButton(
                  platform: platform,
                  url: url,
                ),
              ],
            ),
          ),
        ),
      );
    }

    testWidgets(
      'launches passed url',
      (tester) async {
        const url = 'https://example.com';
        await testLink(
          pumpWidget: (tester) => pumpIcon(
            tester,
            url: url,
            platform: SocialMediaPlatform.twitter,
          ),
          tester: tester,
          find: find.byType(SocialMediaIconButton),
          uri: url,
        );
      },
    );
  });
}
