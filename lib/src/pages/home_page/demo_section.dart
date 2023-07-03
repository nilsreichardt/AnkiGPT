import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:flutter/material.dart';

class DemoSection extends StatelessWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const TutorialVideoPlayer(
      aspectRatio: 16 / 9,
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fankigpt.mp4?alt=media&token=4ffb0db0-b24d-4bc5-87bc-f339725105d6',
    );
  }
}
