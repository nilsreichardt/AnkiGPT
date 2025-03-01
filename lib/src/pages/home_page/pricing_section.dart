import 'dart:async';
import 'dart:math';

import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
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
      priceUsdPart: '\$0',
      points: const [
        PointData(
          '$freeUsageLimitPerMonth cards per month',
        ),
        PointData('Up to 50 cards per deck'),
      ],
      onPressedCallToAction: () {
        final key = ref.read(homePageScrollViewProvider).inputSectionKey;
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
      priceUsdPart: '\$14',
      priceCentPart: '.99',
      priceDescription: 'Lifetime (one-time payment)',
      points: const [
        PointData(
          'Unlimited cards per month',
        ),
        PointData('Up to 150 cards per deck'),
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
    required this.priceUsdPart,
    this.priceCentPart,
    required this.points,
    required this.onPressedCallToAction,
    required this.callToActionText,
    this.priceDescription,
    this.isEnabled = true,
  });

  final String name;
  final String priceUsdPart;
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
        height: _isMobileView(context) ? 350 : 320,
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
                    priceUsdPart: priceUsdPart,
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
    required this.priceUsdPart,
    required this.priceCentPart,
  });

  final String priceUsdPart;
  final String? priceCentPart;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          priceUsdPart,
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
        title: Text(text),
        trailing: trailing,
        subtitle: description != null ? Text(description!) : null,
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
