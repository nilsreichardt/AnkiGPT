import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/buy_button_analytics.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool _isMobileView(BuildContext context) =>
    MediaQuery.of(context).size.width < 735;

class PricingSection extends ConsumerWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      key: ref.read(homePageScollViewProvider).pricingSectionKey,
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
      price: '€0',
      points: const [
        PointData('Up to 20 cards per request'),
        PointData('Up to 5,000 input characters per request'),
        PointData('Delete, edit & search cards'),
      ],
      onPressedCallToAction: () {
        final key = ref.read(homePageScollViewProvider).inputSectionKey;
        scrollTo(context: context, key: key);
      },
      callToActionText: 'Get started',
    );
  }
}

class _PlusTier extends ConsumerStatefulWidget {
  const _PlusTier();

  @override
  ConsumerState<_PlusTier> createState() => _PlusTierState();
}

class _PlusTierState extends ConsumerState<_PlusTier> {
  @override
  void initState() {
    super.initState();

    final hasAccount = ref.read(hasAccount2Provider);
    if (hasAccount) {
      // Generating URL in the background to avoid being blocked by Safari for not
      // being triggered by a user action when the user clicks on the button.
      ref.read(stripeCheckoutProvider.notifier).generateUrl();
    }
  }

  Future<void> buy() async {
    final hasAccount = ref.read(hasAccount2Provider);
    unawaited(ref.read(clickedBuyProvider.future));

    if (hasAccount) {
      await ref.read(stripeCheckoutProvider.notifier).open();
    } else {
      ref.read(wantsToBuyProvider.notifier).toggle();
      Navigator.pushNamed(context, '/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPlus = ref.watch(hasPlusProvider);
    return _TierBase(
      name: 'Plus',
      price: '€9.99',
      priceDescription: 'Lifetime',
      points: const [
        PointData('PDF files as input', trailing: _PdfPointHelpButton()),
        PointData('Up to 200 cards per request'),
        PointData('Unlimited input characters per request'),
        PointData('Premium support'),
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
    required this.price,
    required this.points,
    required this.onPressedCallToAction,
    required this.callToActionText,
    this.priceDescription,
    this.isEnabled = true,
  });

  final String name;
  final String price;
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
            : 320,
        height: 480,
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
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(priceDescription ?? ''),
                ],
              ),
            ),
            ...points.map(
              (point) => SellingPoint(
                text: point.text,
                trailing: point.trailing,
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
    this.trailing,
  });

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      title: Text(text),
      trailing: trailing,
    );
  }
}

class _PdfPointHelpButton extends StatelessWidget {
  const _PdfPointHelpButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Details',
      icon: const Icon(Icons.help_outline),
      onPressed: () => showModal(
        context: context,
        builder: (context) => const _PdfPointHelpDialog(),
      ),
    );
  }
}

class _PdfPointHelpDialog extends StatelessWidget {
  const _PdfPointHelpDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('PDF Input'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: min(MediaQuery.of(context).size.height * 2, 450),
            child: const TutorialVideoPlayer(
              aspectRatio: 16 / 10.6,
              videoUrl:
                  'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fpdf-upload-tutorial.mp4?alt=media&token=a67cd7c1-ff89-41e8-a1f0-9daebe1caaed',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '* You can upload PDF files as input.\n'
            '* Generating 100 - 200 cards takes about 5 - 10 minutes.\n'
            '* Only text is extracted from the PDF file (images are ignored)',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CLOSE'),
        ),
      ],
    );
  }
}

class PointData {
  final String text;
  final Widget? trailing;

  const PointData(
    this.text, {
    this.trailing,
  });
}
