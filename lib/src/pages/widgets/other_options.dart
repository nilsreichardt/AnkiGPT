import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OthersOptionsItem {
  imprint,
  privacy,
  feedback,
  github;

  String getUiText(BuildContext context) {
    switch (this) {
      case OthersOptionsItem.feedback:
        return 'Feedback';
      case OthersOptionsItem.imprint:
        return 'Imprint';
      case OthersOptionsItem.github:
        return 'GitHub';
      case OthersOptionsItem.privacy:
        return 'Privacy Policy';
    }
  }
}

class OthersOptions extends StatelessWidget {
  const OthersOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OthersOptionsItem>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => OthersOptionsItem.values
          .map((item) => PopupMenuItem<OthersOptionsItem>(
                value: item,
                child: Text(item.getUiText(context)),
              ))
          .toList(),
      onSelected: (OthersOptionsItem item) {
        switch (item) {
          case OthersOptionsItem.feedback:
            launchUrl(Uri.parse('https://wa.me/4915229504121'));
          case OthersOptionsItem.github:
            launchUrl(Uri.parse('https://github.com/nilsreichardt/ankigpt'));
            break;
          case OthersOptionsItem.imprint:
            Navigator.of(context).pushNamed('/imprint');
            break;
          case OthersOptionsItem.privacy:
            const url = 'https://ankigpt.wtf/privacy-policy';
            launchUrl(Uri.parse(url));
            break;
        }
      },
    );
  }
}
