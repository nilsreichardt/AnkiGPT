import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showSuccessfulPlusPaymentDialog(BuildContext context) {
  showModal(
    context: context,
    builder: (context) => const _SuccessfulPlusPaymentDialog(),
    routeSettings: const RouteSettings(name: '/successful-plus-payment-dialog'),
  );
}

class _SuccessfulPlusPaymentDialog extends StatefulWidget {
  const _SuccessfulPlusPaymentDialog();

  @override
  State<_SuccessfulPlusPaymentDialog> createState() =>
      _SuccessfulPlusPaymentDialogState();
}

class _SuccessfulPlusPaymentDialogState
    extends State<_SuccessfulPlusPaymentDialog> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 6),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/diamond.svg',
                  height: 160,
                ),
                Text(
                  'Payment successful <3',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Thank you for your support!\nYou have now the following advantages:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 22),
                const PlusAdvantages(),
                const SizedBox(height: 22),
                MaxWidthConstrainedBox(
                  maxWidth: 350,
                  child: Text(
                    'In case the upgrade does not work, please contact the support (see bottom of the page).',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
