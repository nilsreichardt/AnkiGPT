import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_generation_size_provider.g.dart';

@riverpod
class GenerationSize extends _$GenerationSize {
  static const defaultSize = CardGenrationSize.ten;

  @override
  CardGenrationSize build() {
    return defaultSize;
  }

  void set(CardGenrationSize size) {
    state = size;
  }
}
