import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The logo of AnkiGPT with the lettering "AnkiGPT".
class AnkiGptTextLogo extends StatelessWidget {
  const AnkiGptTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/ankigpt_text_logo.svg',
    );
  }
}
