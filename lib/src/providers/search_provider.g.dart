// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'24f27e705d998a4c939964f32870d3b5e9204d83';

/// [SearchQuery] is a Riverpod provider that handles a search input with
/// debouncing functionality.
///
/// This class manages user's search query input in a search bar. To prevent
/// excessive updates and ensure better performance, the [SearchQuery] class
/// debounces the input by a specific duration, which can be set through the
/// [_debounceDuration] property. Setting the debounce duration only for testing
/// purposes.
///
/// Debouncing refers to the practice of delaying the processing of a function
/// (in this case, the search query) until a certain amount of time has passed
/// without the function being called. This technique is particularly useful in
/// search functionalities where the input may frequently change, like in a
/// search bar.
///
/// The default debounce duration is set to 1 second (`_debounceDuration`), but
/// can be modified for testing purposes via the `setDebounceDuration` method.
///
/// Usage:
///
/// * `debounce(String query)`: This method takes the new query as a string,
///   cancels any ongoing debounce, and starts a new one. When the debounce
///   timer completes, it updates the search query state.
///
/// * `fire()`: This method immediately fires the debounce timer for the current
///   debounced query, which causes the search results to update with the
///   current query. This is useful when you want the search results to update
///   immediately upon a search query submission.
///
/// * `clear()`: This method is used to clear the search bar query and cancels
///   any ongoing debounce timers. This is usually used when a user cancels a
///   search or navigates away from the search page.
///
/// This class requires the use of the [EasyDebounce] package to handle
/// debouncing functionality, and works in tandem with the [IsSearchLoading]
/// Riverpod provider to manage search loading state.
///
/// Please note that while this provider is kept alive (`@Riverpod(keepAlive:
/// true)`), any active debounce timers will be cancelled when the provider is
/// disposed to prevent any unintended side effects.
///
/// Copied from [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider = NotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = Notifier<String>;
String _$isSearchLoadingHash() => r'44a4cfe4526b1ab9fd169ede1b0dc6939e818202';

/// [IsSearchLoading] is a Riverpod provider that maintains the state of a
/// loading process, particularly in the context of a search operation.
///
/// This class is a simple state notifier that handles the boolean state
/// representing the loading status of a search process. The class is intended
/// to be used in conjunction with a search operation where the state changes
/// based on whether the search is currently processing (`true`) or not
/// (`false`).
///
/// The initial state is set to `false` in the [build] method, indicating that
/// there's no search operation taking place by default.
///
/// Usage:
///
/// * `set(bool value)`: This method is used to manually set the state of the
///   loading process. A `true` value indicates that a search operation is in
///   progress and a `false` value indicates the opposite.
///
/// This class plays a crucial role in providing a responsive user interface by
/// allowing the application to respond to the loading state of a search
/// operation. For instance, it can be used to display a loading spinner during
/// a search operation and to hide it once the operation is completed.
///
/// Please note that this provider is kept alive (`@Riverpod(keepAlive: true)`)
/// to ensure that the loading state is preserved across widget rebuilds and
/// does not reset unexpectedly.
///
/// Always ensure to correctly manage this state by setting it to `true` at the
/// start of a search operation and back to `false` once the operation has
/// completed.
///
/// Copied from [IsSearchLoading].
@ProviderFor(IsSearchLoading)
final isSearchLoadingProvider =
    NotifierProvider<IsSearchLoading, bool>.internal(
  IsSearchLoading.new,
  name: r'isSearchLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSearchLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsSearchLoading = Notifier<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
