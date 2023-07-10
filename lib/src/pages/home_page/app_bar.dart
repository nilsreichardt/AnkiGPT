import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/app_bar_widgets.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageAppBar2 extends ConsumerWidget implements PreferredSizeWidget {
  const HomePageAppBar2({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return context.isMobile
        ? const _AppBarSmallScreen()
        : const _AppBarLargeScreen();
  }
}

class _AppBarSmallScreen extends StatelessWidget {
  const _AppBarSmallScreen();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        height: 1,
        child: DrawerButton(
          style: IconButton.styleFrom(
            foregroundColor: blackGreen,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: true,
      title: const SizedBox(
        height: 40,
        child: AnkiGptMembershipTextLogo(),
      ),
      actions: const [
        AccountPageIconButton(),
      ],
    );
  }
}

class _AppBarLargeScreen extends ConsumerWidget {
  const _AppBarLargeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return AppBar(
      leadingWidth: hasPlus ? 200 : 150,
      leading: const Padding(
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        child: AnkiGptMembershipTextLogo(),
      ),
      centerTitle: true,
      title: const _NavigationItems(),
      actions: const [
        AccountPageIconButton(),
      ],
    );
  }
}

class _NavigationItems extends ConsumerWidget {
  const _NavigationItems();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaceBetweenItems = SizedBox(width: context.isDesktop ? 16 : 0);
    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            foregroundColor: blackGreen,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScollViewProvider).demoSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('Demo'),
          ),
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScollViewProvider).pricingSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('Pricing'),
          ),
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScollViewProvider).aboutSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('About'),
          ),
          spaceBetweenItems,
          TextButton(
            onPressed: () {
              final key = ref.read(homePageScollViewProvider).faqSectionKey;
              scrollTo(context: context, key: key);
            },
            child: const Text('FAQ'),
          ),
        ],
      ),
    );
  }
}
