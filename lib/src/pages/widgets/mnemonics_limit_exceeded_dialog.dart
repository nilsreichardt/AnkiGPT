import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MnemonicsLimitExceededDialog extends StatelessWidget {
  const MnemonicsLimitExceededDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PlusDialog(
      top: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: MaxWidthConstrainedBox(
          maxWidth: 500,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[100]!.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: MarkdownBody(
              data: '''**Limit reached!**

As a free user, you can create a maximum of $freeMnemonicsUsagePerMonth mnemonics per month and you reached this limit. To produce more mnemonics, consider upgrading to Plus.''',
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
