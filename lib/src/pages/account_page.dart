import 'dart:async';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/cancel_text_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/staggered_list.dart';
import 'package:ankigpt/src/providers/account_view_provider.dart';
import 'package:ankigpt/src/providers/clear_session_state_provider.dart';
import 'package:ankigpt/src/providers/delete_user_controller.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/sign_in_provider.dart';
import 'package:ankigpt/src/providers/sign_out_provider.dart';
import 'package:ankigpt/src/providers/stripe_portal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

/// The number of days after which the account will be deleted if the user
/// does not cancel the deletion.
///
/// If changed, also update the backend.
const int accountDeletionPeriodDays = 7;

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(accountViewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  maxWidth: 900,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey(view.hashCode),
                      child: view.map(
                        signedIn: (_) => const _SignedInSection(),
                        signedOut: (_) => const _SignInSection(),
                      ),
                    ),
                  ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignedInSection extends ConsumerWidget {
  const _SignedInSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return SingleChildScrollView(
      child: StaggeredList(
        children: [
          const _AvatarCard(),
          hasPlus ? const _PlusSection() : const _BuyPlusCard(),
          const _DangerZoneCard(),
        ],
      ),
    );
  }
}

class _BuyPlusCard extends StatelessWidget {
  const _BuyPlusCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        borderRadius: defaultAnkiGptBorderRadius,
        onTap: () => showPlusDialog(context),
        child: const AnkiGptCard(
          padding: EdgeInsets.all(8),
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            leading: Icon(Icons.star),
            title: Text('Upgrade to AnkiGPT Plus'),
          ),
        ),
      ),
    );
  }
}

class _SignInSection extends StatelessWidget {
  const _SignInSection();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: StaggeredList(
          children: [
            _SignInNote(),
            SizedBox(height: 16),
            _GoogleSignIn(),
            SizedBox(height: 12),
            _AppleSignIn(),
            SizedBox(height: 12),
            _LegalText(),
          ],
        ),
      ),
    );
  }
}

class _SignInNote extends StatelessWidget {
  const _SignInNote();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'To use AnkiGPT, please sign in.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'An account is required to prevent abuse.',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}

class _LegalText extends StatelessWidget {
  const _LegalText();

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data:
          'By signing in, you confirm that you read the [Terms of Service](https://ankigpt.help/terms) and [Privacy Policy](https://ankigpt.help/privacy-policy).',
      styleSheet: MarkdownStyleSheet(
        p: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
      ),
      onTapLink: (text, href, title) async {
        if (href == null) return;
        launchUrl(Uri.parse(href));
      },
    );
  }
}

class _AppleSignIn extends StatelessWidget {
  const _AppleSignIn();

  @override
  Widget build(BuildContext context) {
    return _SignInButton(
      icon: SvgPicture.asset('assets/logo/apple-logo.svg'),
      authProvider: AuthProvider.apple,
    );
  }
}

class _GoogleSignIn extends StatelessWidget {
  const _GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return _SignInButton(
      icon: SvgPicture.asset('assets/logo/google-logo.svg'),
      authProvider: AuthProvider.google,
    );
  }
}

class _SignInButton extends ConsumerWidget {
  const _SignInButton({
    required this.icon,
    required this.authProvider,
  });

  final Widget icon;
  final AuthProvider authProvider;

  void _showSnackBar(BuildContext context, Exception e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      maxWidth: 500,
      child: AnkiGptCard(
        borderRadius: defaultAnkiGptBorderRadius,
        onPressed: () async {
          try {
            await ref.read(signInProvider(authProvider: authProvider).future);
          } on Exception catch (e) {
            if (!context.mounted) return;
            _showSnackBar(context, e);
          }
        },
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: icon,
              ),
              const SizedBox(width: 12),
              Text(
                'Sign in with ${authProvider.toUiString()}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DangerZoneCard extends ConsumerWidget {
  const _DangerZoneCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: defaultAnkiGptBorderRadius,
        child: AnkiGptCard(
          padding: const EdgeInsets.all(0),
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
          child: const Column(
            children: [
              _SignOutTile(),
              Divider(height: 0),
              _DeleteOrCancelDeleteAccountTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteOrCancelDeleteAccountTile extends ConsumerWidget {
  const _DeleteOrCancelDeleteAccountTile();

  Future<void> _scheduleDeleteUser(BuildContext context, WidgetRef ref) async {
    final shouldDelete = await showModal<bool>(
      context: context,
      builder: (_) => const _DeleteAccountConfirmationDialog(),
    );

    if (shouldDelete == true && context.mounted) {
      try {
        context.showTextSnackBar(
          'Scheduling account deletion...',
          withLoadingCircle: true,
        );

        final controller = ref.read(deleteUserControllerProvider.notifier);
        await controller.scheduleDeleteUser();

        if (!context.mounted) return;
        context.hideSnackBar();
        context.showTextSnackBar(
            'Your account will be deleted in $accountDeletionPeriodDays days. You can cancel the deletion at any time.');
      } catch (e) {
        if (!context.mounted) return;
        context.hideSnackBar();
        context.showTextSnackBar(
            'Failed to schedule account deletion: ${e.toString()}');
      }
    }
  }

  Future<void> _cancelDeleteUserSchedule(
      BuildContext context, WidgetRef ref) async {
    try {
      context.showTextSnackBar(
        'Cancelling account deletion...',
        withLoadingCircle: true,
      );

      final controller = ref.read(deleteUserControllerProvider.notifier);
      await controller.cancelDeleteUser();

      if (!context.mounted) return;
      context.hideSnackBar();
      context.showTextSnackBar(
          'Account deletion schedule has been canceled. Your account will not be deleted.');
    } on Exception catch (e) {
      if (!context.mounted) return;
      context.hideSnackBar();
      context.showTextSnackBar('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(accountViewProvider) as AccountViewSignedIn;
    final hasDeleteUserSchedule = view.hasDeleteUserSchedule;
    return _DangerZoneTile(
      icon: Icon(hasDeleteUserSchedule ? Icons.delete_forever : Icons.delete),
      title: Text(
          hasDeleteUserSchedule ? 'Cancel delete account' : 'Delete account'),
      onTap: () async {
        if (hasDeleteUserSchedule) {
          await _cancelDeleteUserSchedule(context, ref);
        } else {
          await _scheduleDeleteUser(context, ref);
        }
      },
    );
  }
}

class _DeleteAccountConfirmationDialog extends StatelessWidget {
  const _DeleteAccountConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstrainedBox(
      maxWidth: 500,
      child: AlertDialog(
        title: const Text('Delete account'),
        content: const Text(
          'Are you sure you want to delete your account? Your account will be deleted in $accountDeletionPeriodDays days.',
        ),
        actions: [
          const CancelTextButton(),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('SCHEDULE DELETE'),
          ),
        ],
      ),
    );
  }
}

class _SignOutTile extends ConsumerWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _DangerZoneTile(
      icon: const Icon(Icons.logout),
      title: const Text('Sign out'),
      onTap: () async {
        final shouldSignOut = await showModal<bool>(
          context: context,
          builder: (_) => const _SignOutConfirmationDialog(),
        );

        if (shouldSignOut == true) {
          try {
            ref.read(clearSessionStateProvider.notifier).clear();
            await ref.read(signOutProvider.future);
          } on Exception catch (e) {
            // ignore: use_build_context_synchronously
            context.showTextSnackBar('Error: $e');
          }
        }
      },
    );
  }
}

class _DangerZoneTile extends StatelessWidget {
  const _DangerZoneTile({
    required this.onTap,
    required this.icon,
    required this.title,
  });

  final VoidCallback onTap;
  final Icon icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return _Tile(
      icon: icon,
      title: title,
      onTap: onTap,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.onTap,
    required this.icon,
    required this.title,
    this.color,
    this.subtitle,
  });

  final VoidCallback onTap;
  final Icon icon;
  final Widget title;
  final Color? color;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
        child: icon,
      ),
      title: title,
      onTap: onTap,
      subtitle: subtitle,
    );
  }
}

class _SignOutConfirmationDialog extends StatelessWidget {
  const _SignOutConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        const CancelTextButton(),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('SIGN OUT'),
        ),
      ],
    );
  }
}

class _ContactSupportTile extends StatelessWidget {
  const _ContactSupportTile();

  @override
  Widget build(BuildContext context) {
    return _Tile(
      onTap: () => launchUrl(Uri.parse('https://wa.me/4915229504121')),
      icon: const Icon(Icons.support_agent),
      title: const Text('Contact premium support'),
      subtitle: const Text('Get a response within a few hours'),
    );
  }
}

class _PlusSection extends StatelessWidget {
  const _PlusSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: defaultAnkiGptBorderRadius,
        child: const AnkiGptCard(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              _ContactSupportTile(),
              Divider(height: 0),
              _ManageBills(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ManageBills extends ConsumerStatefulWidget {
  const _ManageBills();

  @override
  ConsumerState<_ManageBills> createState() => _ManageBillsState();
}

class _ManageBillsState extends ConsumerState<_ManageBills> {
  late StripePortal stripePortal;

  @override
  void initState() {
    super.initState();

    // We generate the url in advance because when we would generate it when the user clicks on the tile, the browser
    // could block the popup because it was not triggered by a user action.
    stripePortal = ref.read(stripePortalProvider.notifier);
    unawaited(stripePortal.generateUrl());
  }

  @override
  void dispose() {
    // Reset the state because the url has an expiration date.
    //
    // Wrapping around a [Future.delayed] because other we would change the
    // provider while building the widget tree.
    Future.delayed(Duration.zero).then((_) => stripePortal.reset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Tile(
      onTap: () async {
        try {
          await ref.read(stripePortalProvider.notifier).open();
        } on Exception catch (e) {
          if (!context.mounted) return;
          context.showTextSnackBar('$e');
        }
      },
      icon: const Icon(Icons.payment),
      title: const Text('Payment history'),
    );
  }
}

class _AvatarCard extends ConsumerWidget {
  const _AvatarCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(accountViewProvider);
    if ((view is! AccountViewSignedIn)) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 62.5),
      child: Stack(
        children: <Widget>[
          AnkiGptCard(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 87.0, bottom: 22),
                child: Column(
                  children: [
                    Text(
                      view.email ?? 'Email hidden',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      view.authProvider.toUiString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    if (!view.hasPlus) ...[
                      const SizedBox(height: 32),
                      _FreeUsage(
                        generatedCardsCurrentMonth:
                            view.generatedCardsCurrentMonth,
                        generatedMnemonicsCurrentMonth:
                            view.generatedMnemonicsCurrentMonth,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          FractionalTranslation(
            translation: const Offset(0.0, -0.4),
            child: Align(
              alignment: const FractionalOffset(0.5, 0.0),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 55.0 + 10,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      radius: 55.0,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withValues(alpha: 0.2),
                      child: Icon(
                        Icons.account_circle,
                        color: Theme.of(context).colorScheme.primary,
                        size: 45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FreeUsage extends StatelessWidget {
  const _FreeUsage({
    required this.generatedCardsCurrentMonth,
    required this.generatedMnemonicsCurrentMonth,
  });

  final int generatedCardsCurrentMonth;
  final int generatedMnemonicsCurrentMonth;

  @override
  Widget build(BuildContext context) {
    final percentage = generatedCardsCurrentMonth / freeUsageLimitPerMonth;
    return MaxWidthConstrainedBox(
      maxWidth: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Current usage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
              'Limit: $freeUsageLimitPerMonth cards with per month, ${(percentage * 100).toStringAsFixed(0)}% used'),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(2.5),
          ),
          const SizedBox(height: 6),
          Text('$generatedCardsCurrentMonth cards generated this month'),
          const SizedBox(height: 10),
          const Opacity(
            opacity: 0.7,
            child: Text(
              'Usage will be reset on the 1st of every month. Upgrade to AnkiGPT Plus to get unlimited cards.',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const Divider(height: 38),
          Opacity(
            opacity: 0.7,
            child: Text(
              'Generated mnemonics this month: $generatedMnemonicsCurrentMonth / $freeMnemonicsUsagePerMonth',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
