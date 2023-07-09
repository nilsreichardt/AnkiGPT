import 'dart:math';

import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
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
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FreeTier(),
        SizedBox(height: 32),
        _PlusTier(),
      ],
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
        if (key.currentContext != null) {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutQuart,
          );
        } else {
          context.showTextSnackBar('Can not scroll.');
        }
      },
      callToActionText: 'Get started',
    );
  }
}

class _PlusTier extends StatelessWidget {
  const _PlusTier();

  @override
  Widget build(BuildContext context) {
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
      onPressedCallToAction: () => showPlusDialog(context),
      callToActionText: 'Buy',
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
  });

  final String name;
  final String price;
  final String? priceDescription;
  final List<PointData> points;
  final VoidCallback onPressedCallToAction;
  final String callToActionText;

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
              (point) => _SellingPoint(
                text: point.text,
                trailing: point.trailing,
              ),
            ),
            const Expanded(child: SizedBox()),
            _CallToActionButton(
              onPressed: onPressedCallToAction,
              text: callToActionText,
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
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton(
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

class _SellingPoint extends StatelessWidget {
  const _SellingPoint({
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
      onPressed: () => showDialog(
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
      content: SizedBox(
        height: min(MediaQuery.of(context).size.height * 2, 350),
        child: const TutorialVideoPlayer(
          aspectRatio: 16 / 12,
          videoUrl:
              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fpdf-upload-tutorial.mp4?alt=media&token=a67cd7c1-ff89-41e8-a1f0-9daebe1caaed',
        ),
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
