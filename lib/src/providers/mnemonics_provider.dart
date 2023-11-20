import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
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
      if (e.code == 'deadline-exceeded') {
        state = const MnemonicsState.error(
            'The request timed out. Please try again.');
      } else {
        state = MnemonicsState.error('[${e.plugin}/${e.code}] ${e.message}}');
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
      await repository.append(
        mnemonic: mnemonic,
        sessionId: sessionId,
        cardId: cardId,
      );
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
