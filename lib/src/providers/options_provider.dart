import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'options_provider.freezed.dart';
part 'options_provider.g.dart';

@riverpod
class OptionsController extends _$OptionsController {
  static const defaultSize = CardGenrationSize.twenty;
  static const defaultModel = Model.gpt3_5;

  static const defaultOptions = GenerationOptions(
    size: defaultSize,
    model: defaultModel,
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
  }) = _GenerationOptions;

  /// Returns `true` if an option is selected, which requires AnkiGPT Plus.
  bool hasPlusOption() {
    return size.isPlus() || model.isPlus();
  }
}
