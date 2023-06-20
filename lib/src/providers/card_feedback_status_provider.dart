import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_feedback_status_provider.g.dart';

@riverpod
class CardFeedbackStatusController extends _$CardFeedbackStatusController {
  final Map<CardId, CardFeedbackStatus> _cardFeedbackStatusMap = {};

  @override
  Map<CardId, CardFeedbackStatus> build() {
    final view = ref.watch(cardsListControllerProvider);
    for (final card in view.cards) {
      if (card.hasLiked) {
        _cardFeedbackStatusMap[card.id] = CardFeedbackStatus.liked;
      } else if (card.hasDisliked) {
        _cardFeedbackStatusMap[card.id] = CardFeedbackStatus.disliked;
      } else {
        _cardFeedbackStatusMap[card.id] = CardFeedbackStatus.notReviewed;
      }
    }
    return _cardFeedbackStatusMap;
  }

  void setStatus(CardId cardId, CardFeedbackStatus status) {
    state = {
      ..._cardFeedbackStatusMap,
      cardId: status,
    };
  }
}
