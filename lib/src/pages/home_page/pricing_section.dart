import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(title: 'Pricing'),
        SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FreeTier(),
            SizedBox(width: 48),
            _PlusTier(),
          ],
        ),
      ],
    );
  }
}

class _FreeTier extends StatelessWidget {
  const _FreeTier();

  @override
  Widget build(BuildContext context) {
    return _TierBase(
      name: 'Free',
      price: '€0',
      points: const [
        'Up to 20 cards per request',
        'Up to 5,000 input characters pre request',
        'Delete, edit & search cards'
      ],
      onPressedCallToAction: () {
        // Scroll to top
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
        'PDF files as input',
        'Up to 200 cards per request',
        'Unlimited input characters pre request',
        'Premium support',
        'All free features',
      ],
      onPressedCallToAction: () => showPlusDialog(context),
      callToActionText: 'Buy',
    );
  }
}

class _TierBase extends StatelessWidget {
  const _TierBase({
    super.key,
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
  final List<String> points;
  final VoidCallback onPressedCallToAction;
  final String callToActionText;

  @override
  Widget build(BuildContext context) {
    return AnkiGptCard(
      child: SizedBox(
        width: 300,
        height: 520,
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
            ...points.map((point) => _SellingPoint(text: point)),
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
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.check,
        color: Colors.green,
      ),
      title: Text(text),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }
}
