import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/buy_button_analytics.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

bool _isMobileView(BuildContext context) =>
    MediaQuery.of(context).size.width < 840;

class PricingSection extends ConsumerWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      key: ref.read(homePageScrollViewProvider).pricingSectionKey,
      children: [
        const SectionTitle(title: 'Pricing'),
        const SizedBox(height: 48),
        _isMobileView(context) ? const _MobileView() : const _DesktopView()
      ],
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FreeTier(),
          SizedBox(height: 32),
          _PlusTier(),
        ],
      ),
    );
  }
}

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _FreeTier(),
        SizedBox(width: min(48, MediaQuery.of(context).size.width * 0.025)),
        const _PlusTier(),
      ],
    );
  }
}

class _FreeTier extends ConsumerWidget {
  const _FreeTier();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TierBase(
      name: 'Free',
      priceEurPart: '€0',
      points: const [
        PointData(
          '$freeUsageLimitPerMonth cards with GPT-3.5 per month',
        ),
        PointData('Up to 20 cards per deck'),
        PointData('Up to 4,000 input characters per request'),
        PointData('Delete, edit & search cards'),
        PointData(
          'Generate $freeMnemonicsUsagePerMonth mnemonics per month',
          trailing: _HelpMnemonicsIconButton(),
        ),
        PointData('Access the last 5 decks'),
        PointData('Share decks with a link'),
      ],
      onPressedCallToAction: () {
        final key = ref.read(homePageScrollViewProvider).inputSectionKey;
        scrollTo(context: context, key: key);
      },
      callToActionText: 'Get started',
    );
  }
}

class _HelpMnemonicsIconButton extends StatelessWidget {
  const _HelpMnemonicsIconButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'What are mnemonics?',
      onPressed: () => showMnemonicHelpDialog(context),
      icon: const Icon(Icons.help_outline),
    );
  }
}

Future<void> showMnemonicHelpDialog(BuildContext context) {
  return showModal(
    context: context,
    builder: (context) => const _HelpMnemonicsDialog(),
  );
}

class _HelpMnemonicsDialog extends StatelessWidget {
  const _HelpMnemonicsDialog();

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: MaxWidthConstrainedBox(
        maxWidth: 500,
        child: AlertDialog(
          title: const Text('What are mnemonics?'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: min(MediaQuery.of(context).size.height * 2, 300),
                  child: const TutorialVideoPlayer(
                    aspectRatio: 4 / 2.9,
                    videoUrl:
                        'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fmnemonic_demo.mp4?alt=media&token=9c67f440-bc36-4b05-a428-b55d5d660be3',
                  ),
                ),
                const Text(
                  'Mnemonics is a learning technique that helps individuals remember information, typically by associating complex data with simple, easily recalled cues like sequences, words, or images. They often work by creating relatable or familiar connections in the brain, which can facilitate quicker recall and better memory retention.\n\nFor example, the phrase "Every Good Boy Deserves Fudge" is a musical mnemonic used to remember the order of the lines in the treble clef (EGBDF).\n\nWith AnkiGPT you can generate mnemonics for your flashcard with one click.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}

class _PlusTier extends ConsumerStatefulWidget {
  const _PlusTier();

  @override
  ConsumerState<_PlusTier> createState() => _PlusTierState();
}

class _PlusTierState extends ConsumerState<_PlusTier> {
  Future<void> buy() async {
    final hasAccount = ref.read(hasAccount2Provider);
    unawaited(ref.read(clickedBuyProvider.future));

    if (hasAccount) {
      await ref.read(stripeCheckoutProvider.notifier).open();
    } else {
      ref.read(wantsToBuyProvider.notifier).toggle();
      context.go('/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPlus = ref.watch(hasPlusProvider);
    return _TierBase(
      name: 'Plus',
      priceEurPart: '€14',
      priceCentPart: '.99',
      priceDescription: 'Lifetime (one-time payment)',
      points: const [
        PointData('Unlimited cards with GPT-4o mini per month'),
        PointData(
          '$plusGpt4UsageLimitPerMonth cards with GPT-4o per month',
          description: "GPT-4o is the most powerful model by OpenAI",
        ),
        PointData('Up to 150 cards per deck'),
        PointData('Up to 500,000 input characters (~ 200 pages) per deck'),
        PointData(
          'Generate unlimited mnemonics',
          trailing: _HelpMnemonicsIconButton(),
        ),
        PointData('Access all your decks'),
        PointData('All free features'),
      ],
      onPressedCallToAction: buy,
      callToActionText: 'Buy',
      isEnabled: !hasPlus,
    );
  }
}

class _TierBase extends StatelessWidget {
  const _TierBase({
    required this.name,
    required this.priceEurPart,
    this.priceCentPart,
    required this.points,
    required this.onPressedCallToAction,
    required this.callToActionText,
    this.priceDescription,
    this.isEnabled = true,
  });

  final String name;
  final String priceEurPart;
  final String? priceCentPart;
  final String? priceDescription;
  final List<PointData> points;
  final VoidCallback onPressedCallToAction;
  final String callToActionText;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnkiGptCard(
      child: SizedBox(
        width: _isMobileView(context)
            ? MediaQuery.of(context).size.width * 0.85
            : 365,
        height: _isMobileView(context) ? 690 : 650,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Price(
                    priceEurPart: priceEurPart,
                    priceCentPart: priceCentPart,
                  ),
                  Text(priceDescription ?? ''),
                ],
              ),
            ),
            ...points.map(
              (point) => SellingPoint(
                text: point.text,
                trailing: point.trailing,
                description: point.description,
              ),
            ),
            const Expanded(child: SizedBox()),
            _CallToActionButton(
              onPressed: onPressedCallToAction,
              text: callToActionText,
              isEnabled: isEnabled,
            )
          ],
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.priceEurPart,
    required this.priceCentPart,
  });

  final String priceEurPart;
  final String? priceCentPart;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          priceEurPart,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (priceCentPart != null)
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 11),
            child: Text(
              priceCentPart!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600]!,
              ),
            ),
          )
      ],
    );
  }
}

class _CallToActionButton extends StatelessWidget {
  const _CallToActionButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton(
      isEnabled: isEnabled,
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SellingPoint extends StatelessWidget {
  const SellingPoint({
    super.key,
    required this.text,
    this.description,
    this.trailing,
  });

  final String text;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        leading: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: trailing,
        subtitle: description != null
            ? Text(
                description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}

class PointData {
  final String text;
  final String? description;
  final Widget? trailing;

  const PointData(
    this.text, {
    this.trailing,
    this.description,
  });
}
