import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends ConsumerWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Home',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.maybePop(context);
          ref.read(generateNotifierProvider.notifier).reset();
        },
        onDoubleTap: () => ref.read(hasPlusProvider.notifier).toggle(),
        child: SvgPicture.asset(
          'assets/logo/raw_logo.svg',
        ),
      ),
    );
  }
}

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return Text('AnkiGPT${hasPlus ? ' Plus' : ''}');
  }
}

class AccountPageIconButton extends StatelessWidget {
  const AccountPageIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Account',
      icon: const Icon(Icons.account_circle),
      onPressed: () => Navigator.of(context).pushNamed('/account'),
    );
  }
}
