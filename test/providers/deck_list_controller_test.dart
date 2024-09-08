import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/providers/clock_provider.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:ankigpt/src/providers/stream_session_docs_provider.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../utils/riverpod_testing_utils.dart';
import 'stripe_checkout_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Clock>()])
void main() {
  group(DeckListController, () {
    late MockClock clock;

    setUp(() {
      clock = MockClock();
      when(clock.now()).thenReturn(DateTime(2022, 1, 1));
    });

    test('builds a $DeckListLoading state as init state', () {
      final container = createContainer();

      final controller = container.read(deckListControllerProvider.notifier);

      expect(controller.state, isA<DeckListLoading>());
    });

    test('loads $deckListBatchSize cards when initializing', () async {
      final baseDate = DateTime(2021, 1, 1);

      final container = createContainer(
        overrides: [
          ..._createSessionProviders(baseDate, deckListBatchSize),
          clockProvider.overrideWith((ref) => clock),
        ],
      );
      container.listen(
        deckListControllerProvider,
        (previous, next) => {},
        fireImmediately: true,
      );

      await container.pump();
      final state = container.read(deckListControllerProvider);

      expect(state, isA<DeckListLoaded>());
      expect(state.batches.entries, hasLength(1));
      expect(state.decks.map((d) => d.createdAt), [
        for (var i = 0; i < deckListBatchSize; i++) baseDate.addDays(i),
      ]);
    });

    test('loads 2x $deckListBatchSize when calling loadPress', () async {
      final baseDate = DateTime(2021, 1, 1);

      final container = createContainer(
        overrides: [
          ..._createSessionProviders(baseDate, deckListBatchSize * 2),
          clockProvider.overrideWith((ref) => clock),
        ],
      );
      container.listen(
        deckListControllerProvider,
        (previous, next) => {},
        fireImmediately: true,
      );
      await container.pump();

      when(clock.now()).thenReturn(clock.now().add(const Duration(days: 1)));
      final controller = container.read(deckListControllerProvider.notifier);
      controller.loadMore();
      await container.pump();

      final state = container.read(deckListControllerProvider);

      expect(state, isA<DeckListLoaded>());
      expect(state.batches.entries, hasLength(2));
      expect(state.decks.map((d) => d.createdAt), [
        for (var i = 0; i < deckListBatchSize * 2; i++) baseDate.addDays(i),
      ]);
    });

    test('removes last batch when calling loadLess', () async {
      final baseDate = DateTime(2021, 1, 1);

      final container = createContainer(
        overrides: [
          ..._createSessionProviders(
              baseDate, deckListBatchSize + (deckListBatchSize * 0.5).toInt()),
          clockProvider.overrideWith((ref) => clock),
        ],
      );
      container.listen(
        deckListControllerProvider,
        (previous, next) => {},
        fireImmediately: true,
      );
      await container.pump();

      when(clock.now()).thenReturn(clock.now().add(const Duration(days: 1)));
      final controller = container.read(deckListControllerProvider.notifier);
      controller.loadMore();
      await container.pump();

      when(clock.now()).thenReturn(clock.now().add(const Duration(days: 1)));
      controller.loadLess();
      await container.pump();

      final state = container.read(deckListControllerProvider);

      expect(state, isA<DeckListLoaded>());
      expect(state.batches.entries, hasLength(1));
      expect(state.decks.map((d) => d.createdAt), [
        for (var i = 0; i < deckListBatchSize; i++) baseDate.addDays(i),
      ]);
    });
  });

  test('validate if _createSessionProviders works as expected', () async {
    final baseDate = DateTime(2021, 1, 1);

    final overrides = _createSessionProviders(baseDate, 10, batchSize: 3);
    final container = createContainer(overrides: overrides);

    final expectedQuantityOfBatches = (10 / 3).ceil();
    expect(overrides, hasLength(expectedQuantityOfBatches));

    final batch1 = await container
        .read(streamSessionDocsProvider(lastCreatedAt: null).future);
    expect(batch1.map((b) => b.createdAt), [
      baseDate.addDays(0),
      baseDate.addDays(1),
      baseDate.addDays(2),
    ]);

    final batch2 = await container.read(
        streamSessionDocsProvider(lastCreatedAt: batch1.last.createdAt).future);
    expect(batch2.map((b) => b.createdAt), [
      baseDate.addDays(3),
      baseDate.addDays(4),
      baseDate.addDays(5),
    ]);

    final batch3 = await container.read(
        streamSessionDocsProvider(lastCreatedAt: batch2.last.createdAt).future);
    expect(batch3.map((b) => b.createdAt), [
      baseDate.addDays(6),
      baseDate.addDays(7),
      baseDate.addDays(8),
    ]);

    final batch4 = await container.read(
        streamSessionDocsProvider(lastCreatedAt: batch3.last.createdAt).future);
    expect(batch4.map((b) => b.createdAt), [
      baseDate.addDays(9),
    ]);
  });
}

List<Override> _createSessionProviders(
  DateTime baseDate,
  int sessionsQuantity, {
  int batchSize = deckListBatchSize,
}) {
  final overrides = <Override>[];
  var currentDaysAdded = 0;
  final batchesQuantity = (sessionsQuantity / batchSize).ceil();
  for (var i = 0; i < batchesQuantity; i++) {
    final isFirst = i == 0;

    final size = sessionsQuantity > batchSize ? batchSize : sessionsQuantity;
    sessionsQuantity -= size;

    final lastCreatedAt =
        isFirst ? null : baseDate.addDays((batchSize * i) - 1);

    overrides.add(
      streamSessionDocsProvider(lastCreatedAt: lastCreatedAt).overrideWith(
        (ref) => Stream.value(
          <SessionDto>[
            for (var j = currentDaysAdded; j < (batchSize * i) + size; j++)
              _generateSessionDto(
                  createdAt: baseDate.addDays(currentDaysAdded++)),
          ],
        ),
      ),
    );
  }
  return overrides;
}

extension on DateTime {
  DateTime addDays(int x) {
    return add(Duration(days: x));
  }
}

SessionDto _generateSessionDto({
  required DateTime createdAt,
}) {
  const uuid = Uuid();
  return SessionDto(
    title: null,
    id: uuid.v4(),
    language: Language.de,
    input: Input(
      text: uuid.v4(),
      type: InputType.text,
      file: null,
    ),
    createdAt: createdAt,
    csv: null,
    cards: {},
    status: SessionStatus.completed,
    numberOfCards: 0,
    visibility: Visibility.private,
    userId: uuid.v4(),
    model: Model.gpt4o_mini,
  );
}
