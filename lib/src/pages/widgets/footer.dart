import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/social_media_icon_button.dart';
import 'package:ankigpt/src/providers/version_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFB8E7CF),
      child: const MaxWidthConstrainedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: WoltScreenWidthAdaptiveWidget(
            smallScreenWidthChild: _MobileFooter(),
            largeScreenWidthChild: _DesktopFooter(),
          ),
        ),
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  const _DesktopFooter();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _AboutAnkiGpt()),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 1, child: _Product()),
        Expanded(flex: 1, child: _Contact()),
        Expanded(flex: 1, child: _LegalLinks()),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  const _MobileFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AboutAnkiGpt(),
        const SizedBox(height: 32),
        if (context.isTiny)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Product(),
              _Contact(),
              _LegalLinks(),
            ],
          )
        else
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _Product()),
              Expanded(child: _Contact()),
              Expanded(child: _LegalLinks()),
            ],
          )
      ],
    );
  }
}

class _LegalLinks extends StatelessWidget {
  const _LegalLinks();

  @override
  Widget build(BuildContext context) {
    return _LinksList(
      title: 'Legal',
      links: [
        (
          'Terms of Service',
          Uri.parse('https://ankigpt.help/terms-of-service')
        ),
        ('Privacy Policy', Uri.parse('https://ankigpt.help/privacy-policy')),
        ('Imprint', Uri.parse('/imprint')),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact();

  @override
  Widget build(BuildContext context) {
    return _LinksList(
      title: 'Contact',
      links: [
        ('WhatsApp', Uri.parse('https://ankigpt.help/support')),
        ('Email', Uri.parse('mailto:support@ankigpt.help')),
      ],
    );
  }
}

class _Product extends StatelessWidget {
  const _Product();

  @override
  Widget build(BuildContext context) {
    return _LinksList(
      title: 'Product',
      links: [
        ('Source Code', Uri.parse('https://github.com/nilsreichardt/ankigpt')),
        ('Feedback', Uri.parse('https://ankigpt.help/support')),
      ],
    );
  }
}

class _AboutAnkiGpt extends StatelessWidget {
  const _AboutAnkiGpt();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 150,
          height: 40,
          child: AnkiGptTextLogo(),
        ),
        const SizedBox(height: 12),
        MarkdownBody(
          data:
              'Generate flashcards from the lecture slides with one click and easily export them to [Anki](https://apps.ankiweb.net).',
          styleSheet: MarkdownStyleSheet(
            a: DefaultTextStyle.of(context).style.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
        ),
        const SizedBox(height: 12),
        const Text('Flashcards may contain incorrect information!'),
        const SizedBox(height: 12),
        const _ClimateInformation(),
        const SizedBox(height: 12),
        const _Version(),
        const SizedBox(height: 16),
        const _SocialMedia(),
      ],
    );
  }
}

class _ClimateInformation extends StatelessWidget {
  const _ClimateInformation();

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data:
          'AnkiGPT will contribute 1% of your purchase to removing CO₂ from the atmosphere. Find here more information about [Stripe Climate](https://climate.stripe.com/26fHGz).',
      styleSheet: MarkdownStyleSheet(
        a: DefaultTextStyle.of(context).style.copyWith(
              decoration: TextDecoration.underline,
            ),
      ),
      onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
    );
  }
}

class _Version extends ConsumerWidget {
  const _Version();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(versionProvider);
    return Text(
      '$version Version',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
    );
  }
}

class _SocialMedia extends StatelessWidget {
  const _SocialMedia();

  @override
  Widget build(BuildContext context) {
    return const SocialMediaIconButton(
      platform: SocialMediaPlatform.github,
      url: 'https://github.com/nilsreichardt/ankigpt',
    );
  }
}

class _LinksList extends StatelessWidget {
  const _LinksList({
    required this.title,
    required this.links,
  });

  final String title;
  final List<_Link> links;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: InkWell(
                onTap: () {
                  if (link.$2.scheme.isEmpty) {
                    context.go('${link.$2}');
                  } else {
                    launchUrl(link.$2);
                  }
                },
                child: Text(link.$1),
              ),
            ),
        ],
      ),
    );
  }
}

typedef _LinkText = String;
typedef _Link = (_LinkText, Uri);
