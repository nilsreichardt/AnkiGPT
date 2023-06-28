import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/providers/developer_mode_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The logo of AnkiGPT with the lettering "AnkiGPT".
class AnkiGptTextLogo extends StatelessWidget {
  const AnkiGptTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/ankigpt_text_logo.svg',
    );
  }
}

/// The logo of AnkiGPT with the lettering "AnkiGPT Plus".
///
/// This logo is used when the user has a Plus membership.
class AnkiGptPlusTextLogo extends StatelessWidget {
  const AnkiGptPlusTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/ankigpt_plus_text_logo.svg',
    );
  }
}

/// The logo of AnkiGPT with the lettering "AnkiGPT" or "AnkiGPT Plus".
///
/// This widget automatically switches between the two logos depending on the
/// user's membership status.
class AnkiGptMembershipTextLogo extends ConsumerWidget {
  const AnkiGptMembershipTextLogo({
    this.tooltipKey,
    super.key,
  });

  /// The key of the tooltip that is shown when the user hovers over the logo.
  ///
  /// This is used for testing.
  final GlobalKey<TooltipState>? tooltipKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return Tooltip(
      key: tooltipKey,
      message: 'Home',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ref.read(generateNotifierProvider.notifier).reset();
          Navigator.maybePop(context);
        },
        onLongPress: () {
          ref.read(hasDeveloperModeProvider.notifier).toggle();
          final isDeveloperMode = ref.read(hasDeveloperModeProvider);
          context.showTextSnackBar(
              'Developer mode is now ${isDeveloperMode ? 'enabled' : 'disabled'}');
        },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child:
              hasPlus ? const AnkiGptPlusTextLogo() : const AnkiGptTextLogo(),
        ),
      ),
    );
  }
}
