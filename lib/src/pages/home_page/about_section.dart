import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/pages/widgets/social_media_icon_button.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstrainedBox(
      maxWidth: 850,
      child: Column(
        children: [
          SectionTitle(title: 'About'),
          SizedBox(height: 48),
          _AboutCard(),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: AnkiGptCard(
        padding: const EdgeInsets.all(0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: _Left(),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _Right(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Left extends StatelessWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Image.asset(
        'assets/images/about-image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Right extends StatelessWidget {
  const _Right({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Do use SVG instead of emoji
          const Text('Hey there 👋',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 12),
          Text(
            "I'm Nils, I study computer science at the Technical University Munich (TUM).",
            style: textStyle,
          ),
          const SizedBox(height: 14),
          Text(
            "The grind of crafting high end flashcards was real, draining hours of my week. So, I decided to shake things up and thus, AnkiGPT was born. It's the ultimate fusion of AI wizardry and savvy study hacks. Dive in, and let's turn learning into an epic win, together.",
            style: textStyle,
          ),
          const SizedBox(height: 14),
          Text(
            'Thanks to Niklas for helping to spread the word about AnkiGPT  ❤️',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 14),
          const _SocialMedias(),
        ],
      ),
    );
  }
}

class _SocialMedias extends StatelessWidget {
  const _SocialMedias();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SocialMediaIconButton(
          url: 'https://github.com/nilsreichardt',
          platform: SocialMediaPlatform.github,
        ),
        SizedBox(width: 12),
        SocialMediaIconButton(
          url: 'https://www.linkedin.com/in/nilsreichardt',
          platform: SocialMediaPlatform.linkedin,
        ),
        SizedBox(width: 12),
        SocialMediaIconButton(
          url: 'https://instagram.com/nilsreichardt',
          platform: SocialMediaPlatform.instagram,
        ),
        SizedBox(width: 12),
        SocialMediaIconButton(
          url: 'https://twitter.com/nilsreichardt',
          platform: SocialMediaPlatform.twitter,
        ),
      ],
    );
  }
}
