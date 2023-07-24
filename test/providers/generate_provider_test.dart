import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<Logger>()])
import 'generate_provider_test.mocks.dart';

void main() {
  group('GenerateProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: [
        hasPlusProvider.overrideWithValue(false),
        loggerProvider.overrideWithValue(MockLogger()),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('should be initial state', () {
      final state = container.read(generateNotifierProvider);
      expect(state, const GenerateState.initial());
    });

    group('.submit()', () {
      test('throw exception when text is too short', () {
        // Generate String with 299 characters
        final text = List.generate(399, (index) => 'a').join();

        container.read(inputTextFieldControllerProvider).text = text;

        // Except that .submit throws TooShortInputException
        expect(
          () => container.read(generateNotifierProvider.notifier).submit(),
          throwsA(isA<TooShortInputException>()),
        );
      });

      test(
          'throw exception when text is too long and user has not plus version',
          () {
        // Generate String with 5,001 characters
        final text = List.generate(4001, (index) => 'a').join();

        container.read(inputTextFieldControllerProvider).text = text;

        // Except that .submit throws TooLongInputException
        expect(
          () => container.read(generateNotifierProvider.notifier).submit(),
          throwsA(isA<TooLongInputException>()),
        );
      });

      test('throws exception when user has selected a plus size', () {
        container
            .read(generationSizeProvider.notifier)
            // Fifty cards are only inlcuded in plus version
            .set(CardGenrationSize.fifty);

        // Except that .submit throws PlusVersionException
        expect(
          () => container.read(generateNotifierProvider.notifier).submit(),
          throwsA(isA<PlusMembershipRequiredException>()),
        );
      });
    });
  });
}
