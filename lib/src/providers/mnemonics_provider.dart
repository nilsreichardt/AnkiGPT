import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/card_text_editing_controller_provider.dart';
import 'package:ankigpt/src/providers/mnemonics_repository_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mnemonics_provider.freezed.dart';
part 'mnemonics_provider.g.dart';

typedef Mnemonic = String;

@riverpod
class MnemonicsController extends _$MnemonicsController {
  @override
  MnemonicsState build() {
    return const MnemonicsState.generating();
  }

  Future<void> generate({
    required CardId cardId,
    required SessionId sessionId,
    required String question,
    required String answer,
  }) async {
    state = const MnemonicsState.generating();

    try {
      final repository = ref.read(mnemonicsRepositoryProvider);
      final mnemonic = await repository.generate(
        answer: answer,
        question: question,
        cardId: cardId,
        sessionId: sessionId,
      );
      state = MnemonicsState.loaded(mnemonic);
    } on FirebaseFunctionsException catch (e) {
      switch (e.code) {
        case 'deadline-exceeded':
          state = const MnemonicsState.error(
              'The request timed out. Please try again.');
          break;
        case 'resource-exhausted':
          state = const MnemonicsState.error(
              'You have reached your monthly limit of mnemonics. Please upgrade to the plus plan to get unlimited mnemonics.');
          break;
        default:
          state = MnemonicsState.error('[${e.plugin}/${e.code}] ${e.message}}');
          break;
      }
    } on Exception catch (e) {
      state = MnemonicsState.error('$e');
    }
  }

  Future<void> append({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    final mnemonic = state.when(
      generating: () => throw Exception('Mnemonic is generating'),
      appending: () => throw Exception('Mnemonic is appending'),
      error: (message) => throw Exception(message),
      loaded: (mnemonic) => mnemonic,
    );

    state = const MnemonicsState.appending();

    try {
      final repository = ref.read(mnemonicsRepositoryProvider);
      final updatedAnswer = await repository.append(
        mnemonic: mnemonic,
        sessionId: sessionId,
        cardId: cardId,
      );

      final textEditingController =
          ref.read(answerTextEditingControllerProviderProvider(cardId));
      textEditingController.text = updatedAnswer;
    } on Exception catch (e) {
      state = MnemonicsState.error('$e');
    }
  }

  void update(String mnemonic) {
    state = MnemonicsState.loaded(mnemonic);
  }
}

@freezed
class MnemonicsState with _$MnemonicsState {
  const factory MnemonicsState.generating() = MnemonicsStateGenerating;
  const factory MnemonicsState.appending() = MnemonicsStateAppending;
  const factory MnemonicsState.error(String message) = MnemonicsStateError;
  const factory MnemonicsState.loaded(Mnemonic mnemonic) = MnemonicsStateLoaded;
}
