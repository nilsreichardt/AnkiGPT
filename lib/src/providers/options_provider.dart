import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'options_provider.freezed.dart';
part 'options_provider.g.dart';

@riverpod
class OptionsController extends _$OptionsController {
  static const defaultSize = CardGenrationSize.thirty;
  static const defaultModel = Model.gpt4o_mini;
  static const defaultLanguage = Language.auto;

  static const defaultOptions = GenerationOptions(
    size: defaultSize,
    model: defaultModel,
    language: defaultLanguage,
  );

  @override
  GenerationOptions build() {
    return defaultOptions;
  }

  void setSize(CardGenrationSize size) {
    state = state.copyWith(size: size);
  }

  void setModel(Model model) {
    state = state.copyWith(model: model);
  }

  void setLanguage(Language language) {
    state = state.copyWith(language: language);
  }

  void reset() {
    state = defaultOptions;
  }
}

@freezed
class GenerationOptions with _$GenerationOptions {
  const GenerationOptions._();

  const factory GenerationOptions({
    required CardGenrationSize size,
    required Model model,
    required Language language,
  }) = _GenerationOptions;

  /// Returns `true` if an option is selected, which requires AnkiGPT Plus.
  bool hasPlusOption() {
    return size.isPlus() || model.isPlus();
  }
}
