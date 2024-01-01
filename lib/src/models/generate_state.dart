import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_state.freezed.dart';

@freezed
class GenerateState with _$GenerateState {
  const factory GenerateState.initial() = GenerationStateInitial;
  const factory GenerateState.error({required String message}) =
      GenerationStateError;
  const factory GenerateState.loading() = GenerationStateLoading;
  const factory GenerateState.passwordRequired() =
      GenerationStatePasswordRequired;
}
