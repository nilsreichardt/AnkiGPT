import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/pages/widgets/staggered_list.dart';
import 'package:ankigpt/src/providers/account_view_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/sign_in_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(accountViewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: const [
          OthersOptions(),
        ],
      ),
      body: SafeArea(
        child: MaxWidthConstrainedBox(
          maxWidth: 900,
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
      ),
    );
  }
}

class _SignedInSection extends ConsumerWidget {
  const _SignedInSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return SingleChildScrollView(
      child: StaggeredList(
        children: [
          const _AvatarCard(),
          hasPlus ? const _ContactSupportCard() : const _BuyPlusCard(),
          const _DangerZoneCard(),
        ],
      ),
    );
  }
}

class _BuyPlusCard extends StatelessWidget {
  const _BuyPlusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        borderRadius: defaultAnkiGptBorderRadius,
        onTap: () => showDialog(
          context: context,
          builder: (_) => const PlusDialog(),
        ),
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
  const _SignInSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: StaggeredList(
          children: [
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

class _LegalText extends StatelessWidget {
  const _LegalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data:
          'By signing in, you confirm that you read the [Terms of Service](https://ankigpt.wtf/terms) and [Privacy Policy](https://ankigpt.wtf/privacy-policy).',
      styleSheet: MarkdownStyleSheet(
        p: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
  const _AppleSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SignInButton(
      icon: SvgPicture.asset('assets/logo/apple-logo.svg'),
      authProvider: AuthProvider.apple,
    );
  }
}

class _GoogleSignIn extends StatelessWidget {
  const _GoogleSignIn({Key? key}) : super(key: key);

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
    Key? key,
    required this.icon,
    required this.authProvider,
  }) : super(key: key);

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
      child: InkWell(
        borderRadius: defaultAnkiGptBorderRadius,
        onTap: () async {
          try {
            await ref.read(signInProvider(authProvider: authProvider).future);
          } on Exception catch (e) {
            _showSnackBar(context, e);
          }
        },
        child: AnkiGptCard(
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
      ),
    );
  }
}

class _DangerZoneCard extends StatelessWidget {
  const _DangerZoneCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: defaultAnkiGptBorderRadius,
        child: AnkiGptCard(
          padding: const EdgeInsets.all(0),
          color: Theme.of(context).colorScheme.error,
          child: const Column(
            children: [
              _SignOutTile(),
              Divider(height: 0),
              _DeleteAccountTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAccountTile extends StatelessWidget {
  const _DeleteAccountTile();

  @override
  Widget build(BuildContext context) {
    return _DangerZoneTile(
      icon: const Icon(Icons.delete_forever),
      title: const Text('Delete account'),
      onTap: () {},
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
        final shouldSignOut = await showDialog<bool>(
          context: context,
          builder: (_) => const _SignOutConfirmationDialog(),
        );

        if (shouldSignOut == true) {
          ref.read(userRepositoryProvider).signOut();
        }
      },
    );
  }
}

class _DangerZoneTile extends StatelessWidget {
  const _DangerZoneTile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final Icon icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        child: icon,
      ),
      title: title,
      onTap: onTap,
    );
  }
}

class _SignOutConfirmationDialog extends StatelessWidget {
  const _SignOutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

class _ContactSupportCard extends StatelessWidget {
  const _ContactSupportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        borderRadius: defaultAnkiGptBorderRadius,
        onTap: () => launchUrl(Uri.parse('https://wa.me/4915229504121')),
        child: const AnkiGptCard(
          padding: EdgeInsets.all(8),
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            leading: Icon(Icons.support_agent),
            title: Text('Contact premium support'),
            subtitle: Text('Get a response within a few hours'),
          ),
        ),
      ),
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
                          .withOpacity(0.2),
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
