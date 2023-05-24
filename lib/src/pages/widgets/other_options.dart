import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OthersOptionsItem {
  imprint,
  github;

  String getUiText(BuildContext context) {
    switch (this) {
      case OthersOptionsItem.imprint:
        return 'Impressum';
      case OthersOptionsItem.github:
        return 'GitHub';
    }
  }
}

class OthersOptions extends StatefulWidget {
  const OthersOptions({super.key});

  @override
  State<OthersOptions> createState() => OthersOptionsState();
}

class OthersOptionsState extends State<OthersOptions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OthersOptionsItem>(
      itemBuilder: (context) => OthersOptionsItem.values
          .map((item) => PopupMenuItem<OthersOptionsItem>(
                value: item,
                child: Text(item.getUiText(context)),
              ))
          .toList(),
      onSelected: (OthersOptionsItem item) {
        switch (item) {
          case OthersOptionsItem.github:
            launchUrl(Uri.parse('https://github.com/nilsreichardt/ankigpt'));
            break;
          case OthersOptionsItem.imprint:
            Navigator.of(context).pushNamed('/imprint');
            break;
        }
      },
    );
  }
}
