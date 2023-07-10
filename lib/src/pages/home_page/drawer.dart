import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageDrawer extends ConsumerWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spaceBetweenItems = SizedBox(height: 12);
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
                        final key =
                            ref.read(homePageScollViewProvider).inputSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Input'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key =
                            ref.read(homePageScollViewProvider).demoSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Demo'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key = ref
                            .read(homePageScollViewProvider)
                            .pricingSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('Pricing'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key =
                            ref.read(homePageScollViewProvider).aboutSectionKey;
                        scrollTo(context: context, key: key);
                        Navigator.pop(context);
                      },
                      title: const Text('About'),
                    ),
                    spaceBetweenItems,
                    ListTile(
                      onTap: () {
                        final key =
                            ref.read(homePageScollViewProvider).faqSectionKey;
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
                final key = ref.read(homePageScollViewProvider).inputSectionKey;
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
