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
      });

      group('.fire()', () {
        test('fires the query', () async {
          const query = 'test';

          container.read(searchQueryProvider.notifier).debounce(query);
          container.read(searchQueryProvider.notifier).fire(query);

          // Without await, the query should be set immediately.
          expect(container.read(searchQueryProvider), query);
        });
      });
    });
  });
}
