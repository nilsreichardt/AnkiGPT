import 'dart:async';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/buy_button_analytics.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (top != null) top!,
          const PlusAdvantages(),
          const SizedBox(height: 16),
          const _PlusPrice(),
        ],
      ),
      actions: const [
        _CancelButton(),
        _BuyButton(),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('CANCEL'),
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
        SellingPoint(text: 'Unlimited cards per month'),
        SellingPoint(text: 'Up to 250 cards per request'),
        SellingPoint(
            text: 'Up to 500,000 input characters (~ 200 pages) per request'),
        SellingPoint(text: 'Premium support'),
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
          const Text(
            '€9.99',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Lifetime',
            style: TextStyle(
              color: Colors.grey[600]!,
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

  @override
  void initState() {
    super.initState();

    final isSignedIn = ref.read(isSignedInProvider);
    if (isSignedIn) {
      // Generating URL in the background
      unawaited(ref.read(stripeCheckoutProvider.notifier).generateUrl());
    }
  }

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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
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
              child: const Text('BUY'),
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
  const TooLongInputDialog({Key? key}) : super(key: key);

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
