import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountPageIconButton extends StatelessWidget {
  const AccountPageIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Account',
      icon: const Icon(Icons.account_circle),
      onPressed: () => context.go('/account'),
    );
  }
}

class AccountPageButton extends ConsumerWidget {
  const AccountPageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(isSignedInProvider);
    return AnkiGptElevatedButton(
      onPressed: () => context.go('/account'),
      child: Text(isSignedIn ? 'Account' : 'Login'),
    );
  }
}
