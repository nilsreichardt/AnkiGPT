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
