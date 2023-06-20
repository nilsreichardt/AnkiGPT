import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search', () {
    group('SearchQuery', () {
      late ProviderContainer container;
      const Duration fastDebounceDuration = Duration(milliseconds: 5);

      setUp(() {
        container = ProviderContainer();
        container
            .read(searchQueryProvider.notifier)
            .setDebounceDuration(fastDebounceDuration);
      });

      tearDown(() {
        container.dispose();
      });

      test('initial state is empty', () {
        final query = container.read(searchQueryProvider);
        expect(query, isEmpty);
      });

      group('.clear()', () {
        test('clears the query', () async {
          const query = 'test';
          container.read(searchQueryProvider.notifier).debounce(query);
          await Future.delayed(fastDebounceDuration);
          expect(container.read(searchQueryProvider), query);

          container.read(searchQueryProvider.notifier).clear();

          expect(container.read(searchQueryProvider), isEmpty);
        });

        test('sets is loading to false', () {
          container.read(isSearchLoadingProvider.notifier).set(true);

          container.read(searchQueryProvider.notifier).clear();

          expect(container.read(isSearchLoadingProvider), isFalse);
        });
      });

      group('.deounce()', () {
        test('debounces the query', () async {
          const query = 'test';
          container.read(searchQueryProvider.notifier).debounce(query);

          // Without await, the query shouldn't be available.
          expect(container.read(searchQueryProvider), isEmpty);

          await Future.delayed(fastDebounceDuration);

          // After the debounce duration, the query should be available.
          expect(container.read(searchQueryProvider), query);
        });

        test('sets is loading to true when calling the method', () {
          const query = 'test';
          container.read(searchQueryProvider.notifier).debounce(query);

          expect(container.read(isSearchLoadingProvider), isTrue);
        });

        test('sets is loading to false when query has been made', () async {
          const query = 'test';
          container.read(searchQueryProvider.notifier).debounce(query);

          await Future.delayed(fastDebounceDuration);

          expect(container.read(isSearchLoadingProvider), isFalse);
        });

        test('clears immediately when query is empty', () {
          container.read(searchQueryProvider.notifier).debounce('test');
          container.read(searchQueryProvider.notifier).fire();

          container.read(searchQueryProvider.notifier).debounce('');

          // Without await, the query should be set immediately.
          expect(container.read(searchQueryProvider), isEmpty);
        });
      });

      group('.fire()', () {
        test('fires the query', () async {
          const query = 'test';

          container.read(searchQueryProvider.notifier).debounce(query);
          container.read(searchQueryProvider.notifier).fire();

          // Without await, the query should be set immediately.
          expect(container.read(searchQueryProvider), query);
        });
      });
    });

    group('IsSearchingProvider', () {
      late ProviderContainer container;

      setUp(() {
        container = ProviderContainer();
      });

      tearDown(() {
        container.dispose();
      });

      test('initial state is false', () {
        final state = container.read(isSearchLoadingProvider);

        expect(state, isFalse);
      });

      test('.set() sets the state', () {
        container.read(isSearchLoadingProvider.notifier).set(true);

        final state = container.read(isSearchLoadingProvider);

        expect(state, isTrue);
      });
    });
  });
}
