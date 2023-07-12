import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_page_scroll_controller_provider.g.dart';

@riverpod
Raw<ScrollController> deckPageScrollController(
    DeckPageScrollControllerRef ref) {
  return ScrollController();
}
