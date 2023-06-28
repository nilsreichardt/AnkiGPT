import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class HomePageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return AppBar(
      leadingWidth: hasPlus ? 200 : 150,
      leading: const Padding(
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        child: AnkiGptMembershipTextLogo(),
      ),
      actions: const [
        AccountPageIconButton(),
        OthersOptions(),
      ],
    );
  }
}
