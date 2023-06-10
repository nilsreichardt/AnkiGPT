import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_feedback_status_provider.g.dart';

@riverpod
class CardFeedbackStatusController extends _$CardFeedbackStatusController {
  @override
  CardFeedbackStatus build(CardId cardId) {
    return CardFeedbackStatus.notReviewed;
  }

  void setStatus(CardFeedbackStatus status) {
    state = status;
  }
}
