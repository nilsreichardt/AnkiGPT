import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_state.freezed.dart';

@freezed
class GenerateState with _$GenerateState {
  const factory GenerateState.initial({@Default('') String slide}) =
      GenerationStateInitial;
  const factory GenerateState.loading({
    String? sessionId,
    Language? language,
    @Default(false) bool isUploadFile,
  }) = GenerationStateLoading;
  const factory GenerateState.error({
    required String message,
    required SessionId sessionId,
    Language? language,
  }) = GenerationStateError;
  const factory GenerateState.success({
    required SessionId sessionId,
    required String? downloadUrl,
    Language? language,
  }) = GenerationStateSuccess;
}

@freezed
class CardsListView with _$CardsListView {
  const CardsListView._();

  const factory CardsListView({
    required List<AnkiCard> cards,
    required int currentPage,
    required int totalPages,
    required bool canPressNext,
    required bool canPressPrevious,
  }) = _CardsListView;

  factory CardsListView.empty() {
    return const CardsListView(
      cards: [],
      currentPage: 1,
      totalPages: 1,
      canPressNext: false,
      canPressPrevious: false,
    );
  }
}
