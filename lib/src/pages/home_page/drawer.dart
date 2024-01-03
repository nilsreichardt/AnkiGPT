import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageDrawer extends ConsumerWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spaceBetweenItems = SizedBox(height: 12);
    final isSignedIn = ref.watch(isSignedInProvider);
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .inputSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Input'),
                    ),
                    spaceBetweenItems,
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: isSignedIn ? const _DeckTile() : const _DemoTile(),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .pricingSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Pricing'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScrollViewProvider)
                            .aboutSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('About'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key =
                            ref.read(homePageScrollViewProvider).faqSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('FAQ'),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                final key =
                    ref.read(homePageScrollViewProvider).inputSectionKey;
                scrollTo(context: context, key: key);
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  height: 32,
                  child: AnkiGptTextLogo(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoTile extends ConsumerWidget {
  const _DemoTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BasicTile(
      key: const ValueKey('demo-tile'),
      sectionKey: ref.read(homePageScrollViewProvider).demoSectionKey,
      text: 'Demo',
    );
  }
}

class _DeckTile extends ConsumerWidget {
  const _DeckTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BasicTile(
      key: const ValueKey('decks-tile'),
      sectionKey: ref.read(homePageScrollViewProvider).myDecksSectionKey,
      text: 'My Decks',
    );
  }
}

class _BasicTile extends ConsumerWidget {
  const _BasicTile({
    super.key,
    required this.sectionKey,
    required this.text,
  });

  final GlobalKey sectionKey;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        scrollTo(context: context, key: sectionKey);
        Navigator.pop(context);
      },
      title: Text(text),
    );
  }
}
