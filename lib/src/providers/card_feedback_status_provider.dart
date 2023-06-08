import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardFeedbackStatusProvider =
    StateProvider.autoDispose.family<CardFeedbackStatus, CardId>((ref, cardId) {
  return CardFeedbackStatus.notReviewed;
});
