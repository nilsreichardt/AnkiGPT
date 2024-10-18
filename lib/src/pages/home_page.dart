import 'dart:async';

import 'package:ankigpt/src/pages/home_page/app_bar.dart';
import 'package:ankigpt/src/pages/home_page/demo_section.dart';
import 'package:ankigpt/src/pages/home_page/drag_zone.dart';
import 'package:ankigpt/src/pages/home_page/input_section.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/pages/home_page/used_by.dart';
import 'package:ankigpt/src/pages/successful_payment_dialog.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/show_successful_playment_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    this.has0Analytics = false,
  });

  final bool has0Analytics;

  @override
  ConsumerState<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowSuccessfulPayment();
    });

    if (widget.has0Analytics) {
      unawaited(increaseZeroCounter());
      unawaited(setZeroFlag());
    }
  }

  Future<void> increaseZeroCounter() async {
    try {
      final cloudFirestore = ref.read(cloudFirestoreProvider);
      await cloudFirestore.doc('Analytics/0').update({
        // For Attackers: Don't try to increase the counter, it's not possible.
        // The counter is protected by security rules.
        'counter': FieldValue.increment(1),
      });
    } on Exception catch (e) {
      ref.read(loggerProvider).i('Could not increase zero counter', error: e);
    }
  }

  Future<void> setZeroFlag() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('0', true);
    } catch (e) {
      ref.read(loggerProvider).i('Could not set zero flag', error: e);
    }
  }

  void _maybeShowSuccessfulPayment() {
    final notifier = ref.read(showSuccessfulPaymentDialogProvider.notifier);
    final shouldShowSuccessfulPaymentDialog = notifier.get();
    if (shouldShowSuccessfulPaymentDialog) {
      // If the user has just paid, show the successful payment dialog.
      notifier.set(false);
      showSuccessfulPlusPaymentDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSignedIn = ref.watch(isSignedInProvider);
    return SelectionArea(
      child: Scaffold(
        body: DragZone(
          child: MaxWidthConstrainedBox(
            maxWidth: 1600,
            child: SafeArea(
              child: Builder(builder: (context) {
                final isHeightTooSmall =
                    MediaQuery.of(context).size.height < 700;
                final useMobileView = !context.isDesktop || isHeightTooSmall;
                if (useMobileView) {
                  return _MobileHome(isSignedIn: isSignedIn);
                }

                return _DesktopHome(isSignedIn: isSignedIn);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopHome extends StatelessWidget {
  const _DesktopHome({
    required this.isSignedIn,
  });

  final bool isSignedIn;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 1300),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 20,
            child: FadeInAnimation(child: widget),
          ),
          delay: const Duration(milliseconds: 250),
          children: [
            const HomePageAppBar2(),
            // const NewCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: InputSection(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 12,
                    ),
                    child: Container(
                      color: Colors.white12,
                      width: 4,
                      height: 300,
                    ),
                  ),
                  Expanded(
                    child: isSignedIn
                        ? const MyDecksSection()
                        : const DemoSection(),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: isSignedIn ? 0 : 48),
              child: isSignedIn ? const SizedBox() : const UsedBy(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileHome extends StatelessWidget {
  const _MobileHome({
    required this.isSignedIn,
  });

  final bool isSignedIn;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MaxWidthConstrainedBox(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 1000),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 20,
                  child: FadeInAnimation(child: widget),
                ),
                delay: const Duration(milliseconds: 250),
                children: [
                  const Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: HomePageAppBarTitle(),
                      ),
                      Positioned(
                        right: 0,
                        child: HomePageAppBarMoreOptions(),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: InputSection(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Traction(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  isSignedIn ? const MyDecksSection() : const DemoSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
