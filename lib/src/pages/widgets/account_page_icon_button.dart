import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountPageIconButton extends StatelessWidget {
  const AccountPageIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Account',
      icon: const Icon(Icons.account_circle),
      onPressed: () => context.go('/account'),
    );
  }
}
