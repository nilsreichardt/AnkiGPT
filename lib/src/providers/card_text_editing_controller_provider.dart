import 'package:ankigpt/src/models/card_id.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_text_editing_controller_provider.g.dart';

@riverpod
Raw<TextEditingController> answerTextEditingControllerProvider(
  AnswerTextEditingControllerProviderRef ref,
  CardId cardId,
) =>
    TextEditingController();
