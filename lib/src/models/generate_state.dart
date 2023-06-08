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
    @Default([]) List<AnkiCard> alreadyGeneratedCards,
    Language? language,
  }) = GenerationStateLoading;
  const factory GenerateState.error({
    required String message,
    required SessionId sessionId,
    @Default([]) List<AnkiCard> generatedCards,
    Language? language,
  }) = GenerationStateError;
  const factory GenerateState.success({
    required SessionId sessionId,
    required List<AnkiCard> generatedCards,
    required String? downloadUrl,
    Language? language,
  }) = GenerationStateSuccess;
}
