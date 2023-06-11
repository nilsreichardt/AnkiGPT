import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/stream_session_docs_provider.dart';
import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum OthersOptionsItem {
  imprint,
  privacy,
  feedback,
  github,
  signOut;

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
      case OthersOptionsItem.signOut:
        return 'Sign out';
    }
  }
}

class OthersOptions extends ConsumerWidget {
  const OthersOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(isSignedInProvider);
    return PopupMenuButton<OthersOptionsItem>(
      itemBuilder: (context) => OthersOptionsItem.values
          .where((element) {
            if (element == OthersOptionsItem.signOut) return isSignedIn;
            return true;
          })
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
            const url =
                'https://firebasestorage.googleapis.com/v0/b/storage.ankigpt.wtf/o/assets%2Fprivacy_policy_en.pdf?alt=media&token=f20b646d-f7fe-41fa-96d5-98b641cc7b56';
            launchUrl(Uri.parse(url));
            break;
          case OthersOptionsItem.signOut:
            ref.read(userRepositoryProvider).signOut();
            break;
        }
      },
    );
  }
}
