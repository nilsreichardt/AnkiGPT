import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/analytics_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/options_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Logger>(), MockSpec<Analytics>()])
import 'generate_provider_test.mocks.dart';

void main() {
  group('GenerateProvider', () {
    late ProviderContainer container;
    late MockAnalytics analytics;

    setUp(() {
      analytics = MockAnalytics();
      container = ProviderContainer(overrides: [
        hasPlusProvider.overrideWithValue(false),
        loggerProvider.overrideWithValue(MockLogger()),
        analyticsProvider.overrideWithValue(analytics),
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

      test('logs event when text is too long and user has not plus version',
          () async {
        // Generate String with 299 characters
        final text = List.generate(399, (index) => 'a').join();

        container.read(inputTextFieldControllerProvider).text = text;

        try {
          await container.read(generateNotifierProvider.notifier).submit();
        } catch (e) {
          // Do nothing.
        }

        verify(analytics.logEvent(
          'too_short_input',
          page: 'generate',
        )).called(1);
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

      test('logs event when text is too long and user has not plus version',
          () async {
        // Generate String with 5,001 characters
        final text = List.generate(4001, (index) => 'a').join();

        container.read(inputTextFieldControllerProvider).text = text;

        try {
          await container.read(generateNotifierProvider.notifier).submit();
        } catch (e) {
          // Do nothing.
        }

        verify(analytics.logEvent(
          'too_long_input_without_plus',
          page: 'generate',
        )).called(1);
      });

      test('throws exception when user has selected a plus size', () {
        container
            .read(optionsControllerProvider.notifier)
            // Fifty cards are only included in plus version
            .setSize(CardGenrationSize.fifty);

        // Except that .submit throws PlusVersionException
        expect(
          () => container.read(generateNotifierProvider.notifier).submit(),
          throwsA(isA<PlusMembershipRequiredException>()),
        );
      });

      test('logs event when user has selected a plus size', () async {
        container
            .read(optionsControllerProvider.notifier)
            // Fifty cards are only inlcuded in plus version
            .setSize(CardGenrationSize.fifty);

        try {
          await container.read(generateNotifierProvider.notifier).submit();
        } catch (e) {
          // Do nothing.
        }

        verify(analytics.logEvent(
          'plus_required_to_generate',
          page: 'generate',
        )).called(1);
      });
    });
  });
}
