import 'package:ankigpt/src/pages/widgets/animated_swap.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:ankigpt/src/providers/search_text_field_controller.dart';
import 'package:ankigpt/src/providers/total_cards_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardsSearchBar extends ConsumerStatefulWidget {
  const CardsSearchBar({super.key});

  @override
  ConsumerState<CardsSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CardsSearchBar> {
  late bool isSearching;

  @override
  void initState() {
    super.initState();
    isSearching = ref.read(searchTextFieldControllerProvider).text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final cardsCount = ref.watch(totalCardsCountProvider);
    if (cardsCount == 0) {
      return const SizedBox.shrink();
    }

    return AnkiGptCard(
      color: Colors.grey.withValues(alpha: 0.1),
      padding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ref.read(searchTextFieldControllerProvider),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).debounce(query);

                setState(() {
                  isSearching = query.isNotEmpty;
                });
              },
              decoration: const InputDecoration(
                hintText:
                    "Search to ensure AI hasn't overlooked key topics in your flashcards",
                border: InputBorder.none,
              ),
              onEditingComplete: () =>
                  ref.read(searchQueryProvider.notifier).fire(),
            ),
          ),
          const SizedBox(width: 12),
          AnimatedSwap(
            duration: const Duration(milliseconds: 300),
            child: isSearching
                ? IconButton(
                    key: const ValueKey(true),
                    tooltip: 'Clear',
                    onPressed: () =>
                        ref.read(searchQueryProvider.notifier).clear(),
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    key: const ValueKey(false),
                    onPressed: null,
                    icon: const Icon(Icons.search),
                    disabledColor: Theme.of(context).iconTheme.color,
                  ),
          ),
        ],
      ),
    );
  }
}
