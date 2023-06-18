import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_edit_text_field_controller_provider.g.dart';

@riverpod
class CardEditTextFieldController extends _$CardEditTextFieldController {
  final Map<CardId, TextEditingController> _cardFeedbackStatusMap = {};

  @override
  Map<CardId, TextEditingController> build() {
    final generatedState = ref.watch(generateNotifierProvider);
    // if (generatedState is GenerationStateSuccess) {
    //   for (final card in generatedState.generatedCards) {
    //       _cardFeedbackStatusMap[card.id] = TextEditingController(text: card.question);
    //     }
    //   }
    // }
    return _cardFeedbackStatusMap;
  }
}
