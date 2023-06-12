import 'package:ankigpt/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_generation_size_provider.g.dart';

@riverpod
class GenerationSize extends _$GenerationSize {
  @override
  CardGenrationSize build() {
    return CardGenrationSize.five;
  }

  void set(CardGenrationSize size) {
    state = size;
  }
}
