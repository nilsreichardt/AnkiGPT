import 'package:ankigpt/src/pages/home_page/about_section.dart';
import 'package:ankigpt/src/pages/home_page/app_bar.dart';
import 'package:ankigpt/src/pages/home_page/demo_section.dart';
import 'package:ankigpt/src/pages/home_page/drawer.dart';
import 'package:ankigpt/src/pages/home_page/faq_section.dart';
import 'package:ankigpt/src/pages/home_page/input_section.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/pages/successful_payment_dialog.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer2.dart';
import 'package:ankigpt/src/providers/show_successful_playment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage2 extends ConsumerStatefulWidget {
  const HomePage2({super.key});

  @override
  ConsumerState<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends ConsumerState<HomePage2> {
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
    return Scaffold(
      appBar: const HomePageAppBar2(),
      drawer: context.isMobile ? const HomePageDrawer() : null,
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              InputSection(),
              SizedBox(height: 100),
              DemoSection(),
              SizedBox(height: 100),
              PricingSection(),
              SizedBox(height: 100),
              AboutSection(),
              SizedBox(height: 100),
              FaqSection(),
              SizedBox(height: 100),
              Footer2(),
            ],
          ),
        ),
      ),
    );
  }
}
