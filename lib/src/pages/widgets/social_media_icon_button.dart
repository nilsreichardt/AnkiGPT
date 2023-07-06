import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMediaPlatform {
  github,
  linkedin,
  instagram,
  twitter;
}

class SocialMediaIconButton extends StatelessWidget {
  const SocialMediaIconButton({
    super.key,
    required this.url,
    required this.platform,
  });

  final String url;
  final SocialMediaPlatform platform;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(7.5);
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: darkGreen,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            'assets/logo/${platform.name}-logo.svg',
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
