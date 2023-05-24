import 'package:flutter/material.dart';

enum OthersOptionsItem {
  imprint,
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
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: OthersOptionsItem.imprint,
          child: Text('Impressum'),
        ),
      ],
      onSelected: (OthersOptionsItem item) {
        switch (item) {
          case OthersOptionsItem.imprint:
            Navigator.of(context).pushNamed('/imprint');
            break;
        }
      },
    );
  }
}
