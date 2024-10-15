import 'package:ankigpt/src/pages/widgets/account_page_icon_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/providers/traction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageAppBar2 extends StatelessWidget {
  const HomePageAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? const _AppBarSmallScreen()
        : const AppBarLargeScreen();
  }
}

class _AppBarSmallScreen extends StatelessWidget {
  const _AppBarSmallScreen();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AccountPageButton(),
            SizedBox(width: 12),
            _MoreOptions(),
          ],
        ),
        SizedBox(height: 12),
        Center(child: _Title()),
        SizedBox(height: 12),
        _Traction(
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ],
    );
  }
}

class AppBarLargeScreen extends StatelessWidget {
  const AppBarLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(18),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: _Traction(),
          ),
          Center(child: _Title()),
          Positioned(
            right: 0,
            child: Row(
              children: [
                AccountPageButton(),
                SizedBox(width: 12),
                _MoreOptions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Traction extends ConsumerWidget {
  const _Traction({
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getTractionStreamIntProvider);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
              scrollbarTheme:
                  ScrollbarThemeData(thickness: WidgetStateProperty.all(0))),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            key: ValueKey(value),
            child: NumberSlideAnimation(
              number: value.when(
                data: (v) => '$v',
                error: (e, s) => '0',
                loading: () => '000000',
              ),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOut,
              textStyle: const TextStyle(
                // color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Text(
          'Flashcards generated so far'.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: DefaultTextStyle.of(context).style.color?.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MoreOptions extends StatelessWidget {
  const _MoreOptions();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert),
        ),
      ),
      onSelected: (item) => _onSelected(context, item),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(value: 0, child: Text('Support (WhatsApp)')),
        const PopupMenuItem<int>(value: 1, child: Text('Privacy Policy')),
        const PopupMenuItem<int>(value: 2, child: Text('Imprint')),
        const PopupMenuItem<int>(value: 3, child: Text('Terms of Service')),
      ],
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        _launchURL(context, Uri.parse('https://ankigpt.help/support'));
        break;
      case 1:
        _launchURL(context, Uri.parse('https://ankigpt.help/privacy-policy'));
        break;
      case 2:
        _launchURL(context, Uri.parse('/imprint'));
        break;
      case 3:
        _launchURL(context, Uri.parse('https://ankigpt.help/terms-of-service'));
        break;
    }
  }

  void _launchURL(BuildContext context, Uri uri) async {
    if (uri.scheme.isEmpty) {
      context.go('$uri');
    } else {
      launchUrl(uri);
    }
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AnkiGPT',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        Text(
          'Turn lecture slides into flashcards'.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: DefaultTextStyle.of(context).style.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
