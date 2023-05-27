import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required this.releaseDate,
  }) : super(key: key);

  /// The date of the release, should be formatted as 'MONTH DAY YEAR' (e.g. 'June 1 2023').
  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0),
          const SizedBox(height: 4),
          _Links(releaseDate: releaseDate),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _Links extends StatelessWidget {
  const _Links({
    Key? key,
    required this.releaseDate,
  }) : super(key: key);

  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MarkdownBody(
          styleSheet: MarkdownStyleSheet(
            textAlign: WrapAlignment.center,
            p: Theme.of(context).textTheme.bodySmall,
          ),
          data:
              "Flashcards may contain incorrect information! Click [here](https://wa.me/4915229504121) to give feedback or get support. AnkiGPT $releaseDate Version",
          onTapLink: (
            text,
            href,
            _,
          ) {
            if (href == null) return;
            launchUrl(Uri.parse(href));
          },
        ),
      ),
    );
  }
}
