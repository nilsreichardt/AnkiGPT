import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/providers/show_warning_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WarningDoubleCheckCard extends ConsumerWidget {
  const WarningDoubleCheckCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShow = ref.watch(showWarningCardProvider);
    const color = Colors.orange;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: shouldShow
          ? Padding(
              key: const ValueKey('warning-card'),
              padding: const EdgeInsets.only(top: 12),
              child: AnkiGptCard(
                color: color.withValues(alpha: 0.1),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: color, size: 40),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AnkiGPT is your co-pilot, not the captain! Remember, even AI stumbles sometimes, so be sure to double-check those cards. Don't forget, nothing beats the magic of your own creative touch in the flashcard mix!",
                            style: TextStyle(
                              color: color,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hide this warning',
                      onPressed: () =>
                          ref.read(showWarningCardProvider.notifier).hide(),
                      icon: const Icon(Icons.close, color: color),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(key: ValueKey('empty')),
    );
  }
}
