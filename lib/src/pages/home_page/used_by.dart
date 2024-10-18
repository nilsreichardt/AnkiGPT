import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marquee_list/marquee_list.dart';

class UsedBy extends StatelessWidget {
  const UsedBy({super.key});

  @override
  Widget build(BuildContext context) {
    const universities = [
      'tum',
      'stanford',
      'lse',
      'berkeley',
      'oxford',
      'heidelberg',
      'toronto'
    ];
    return Column(
      children: <Widget>[
        // if (context.isDesktop) _SpaceTop(),
        const _Text(),
        const SizedBox(height: 20),
        context.isDesktop
            ? const _LogosDesktop(universities: universities)
            : const _LogosMobile(universities: universities)
      ],
    );
  }
}

class _SpaceTop extends StatelessWidget {
  const _SpaceTop();

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.15);
  }
}

class _LogosDesktop extends StatelessWidget {
  const _LogosDesktop({
    super.key,
    required this.universities,
  });

  final List<String> universities;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (final university in universities) _Logo(university: university),
        ],
      ),
    );
  }
}

class _LogosMobile extends StatelessWidget {
  final List<String> universities;

  const _LogosMobile({required this.universities});

  @override
  Widget build(BuildContext context) {
    return MarqueeList(
      scrollDuration: const Duration(seconds: 4),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        for (int i = 0; i < 2; i++)
          for (final university in universities)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _Logo(university: university),
            ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Used by students of'.toUpperCase(),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white30,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.university});

  final String university;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/$university.svg',
      height: 30,
    );
  }
}
