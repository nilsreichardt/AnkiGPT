import 'dart:async';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/buy_button_analytics.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

void showPlusDialog(
  BuildContext context, {
  Widget? top,
}) {
  showModal(
    context: context,
    builder: (context) => PlusDialog(top: top),
    routeSettings: const RouteSettings(name: '/plus'),
  );
}

void showInputTooLong(BuildContext context) {
  showModal(
    context: context,
    builder: (context) => const TooLongInputDialog(),
    routeSettings: const RouteSettings(name: '/too-long-input'),
  );
}

class PlusDialog extends ConsumerWidget {
  const PlusDialog({
    super.key,
    this.top,
  });

  final Widget? top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("AnkiGPT Plus"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (top != null) top!,
            const PlusAdvantages(),
            const SizedBox(height: 16),
            const _PlusPrice(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actions: const [
        _BuyButton(),
        _CancelButton(),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class PlusAdvantages extends StatelessWidget {
  const PlusAdvantages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SellingPoint(text: 'Unlimited cards with GPT-4o mini per month'),
        SellingPoint(
          text: '$plusGpt4UsageLimitPerMonth cards with GPT-4o per month',
          description: 'GPT-4o is the most powerful model by OpenAI',
        ),
        SellingPoint(text: 'Up to 150 cards per deck'),
      ],
    );
  }
}

class _PlusPrice extends StatelessWidget {
  const _PlusPrice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Price(
            priceEurPart: '€14',
            priceCentPart: '.99',
          ),
          Text(
            'Lifetime (one-time payment)',
            style: TextStyle(
              color: Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyButton extends ConsumerStatefulWidget {
  const _BuyButton();

  @override
  ConsumerState<_BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends ConsumerState<_BuyButton> {
  bool isLoading = false;

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
    return Stack(
      children: [
        Opacity(
          opacity: isLoading ? 0 : 1,
          child: IgnorePointer(
            ignoring: isLoading,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    await buy();
                  } on Exception catch (e) {
                    if (!context.mounted) return;
                    context.showTextSnackBar('Error while buying Plus: $e');
                    Navigator.pop(context);
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: const Text('UPGRADE TO PLUS'),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: isLoading ? 1 : 0,
          child: IgnorePointer(
            ignoring: !isLoading,
            child: const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}

class TooLongInputDialog extends StatelessWidget {
  const TooLongInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaxWidthConstrainedBox(
      maxWidth: 500,
      child: AlertDialog(
        title: Text('Input too long!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnkiGptCard(
              color: Color(0xFFFFDFDF),
              child: Text(
                'Your text is too long. Free users have a limt of 4,000 characters. Buy AnkiGPT Plus to remove this limit.',
                style: TextStyle(color: Color(0xFFD90000)),
              ),
            ),
            SizedBox(height: 16),
            PlusAdvantages(),
          ],
        ),
        actions: [
          _CancelButton(),
          _BuyButton(),
        ],
      ),
    );
  }
}
