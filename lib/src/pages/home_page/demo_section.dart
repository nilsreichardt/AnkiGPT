import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoSection extends ConsumerWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MaxWidthConstrainedBox(
        key: ref.read(homePageScrollViewProvider).demoSectionKey,
        child: const TutorialVideoPlayer(
          aspectRatio: 16 / 9.6,
          videoUrl:
              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fankigpt.mp4?alt=media&token=4ffb0db0-b24d-4bc5-87bc-f339725105d6',
        ),
      ),
    );
  }
}
