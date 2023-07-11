import 'package:ankigpt/src/pages/home_page/about_section.dart';
import 'package:ankigpt/src/pages/home_page/app_bar.dart';
import 'package:ankigpt/src/pages/home_page/demo_section.dart';
import 'package:ankigpt/src/pages/home_page/drawer.dart';
import 'package:ankigpt/src/pages/home_page/faq_section.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/pages/home_page/input_section.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/pages/successful_payment_dialog.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/show_successful_playment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

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
    return Scaffold(
      appBar: const HomePageAppBar2(),
      drawer: context.isMobile ? const HomePageDrawer() : null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Wrapping the widgets around a ConstrainedBox always show the
              // footer at the bottom of the page.
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  children: [
                    const InputSection(),
                    const SizedBox(height: 100),
                    isSignedIn ? const MyDecksSection() : const DemoSection(),
                    const SizedBox(height: 100),
                    const PricingSection(),
                    const SizedBox(height: 100),
                    const AboutSection(),
                    const SizedBox(height: 100),
                    const FaqSection(),
                    const SizedBox(height: 100),
                  ],
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
