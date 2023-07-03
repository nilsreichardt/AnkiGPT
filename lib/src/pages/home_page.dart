import 'package:ankigpt/src/pages/home_page/app_bar.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageAppBar2(),
      drawer: context.isMobile ? const Drawer() : null,
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
