import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final generateStateProvider =
    StateNotifierProvider<GenerateNotifier, GenerateState>(
  (ref) {
    final logger = ref.watch(loggerProvider);
    return GenerateNotifier(
      logger: logger,
    );
  },
);

class GenerateNotifier extends StateNotifier<GenerateState> {
  final Logger logger;

  GenerateNotifier({
    required this.logger,
  }) : super(const GenerateState.initial());

  Future<void> submit() async {
    logger.d("Generating cards...");

    state = const GenerateState.loading();
    await Future.delayed(const Duration(seconds: 2));

    final cards = <AnkiCard>[];
    cards.addAll(const [
      AnkiCard(
        front: 'What is the capital of France?',
        back: 'Paris',
      ),
      AnkiCard(
        front: 'What is the capital of Germany?',
        back: 'Berlin',
      ),
      AnkiCard(
        front: 'What is the capital of Italy?',
        back: 'Rome',
      ),
    ]);
    state = state = GenerateState.loading(alreadyGeneratedCards: cards);

    await Future.delayed(const Duration(seconds: 2));
    cards.addAll(const [
      AnkiCard(
        front: 'What is the capital of Spain?',
        back: 'Madrid',
      ),
      AnkiCard(
        front: 'What is the capital of Portugal?',
        back: 'Lisbon',
      ),
      AnkiCard(
        front: 'What is the capital of the Netherlands?',
        back: 'Amsterdam',
      ),
    ]);

    state = state = GenerateState.success(generatedCards: cards);
  }
}