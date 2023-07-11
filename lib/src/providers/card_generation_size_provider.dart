import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_generation_size_provider.g.dart';

@riverpod
class GenerationSize extends _$GenerationSize {
  @override
  CardGenrationSize build() {
    return CardGenrationSize.ten;
  }

  void set(CardGenrationSize size) {
    state = size;
  }
}
