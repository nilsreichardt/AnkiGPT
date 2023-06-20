import 'package:ankigpt/src/providers/search_text_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

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
@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  /// The key used to debounce the search query.
  ///
  /// This property is used to debounce the search query entered by the user in
  /// the search bar. It is used by the [debounce] and [fire] methods to
  /// debounce the query and prevent the search results from updating too
  /// frequently.
  static const _debounceKey = 'search';

  /// The duration used to debounce the search query.
  ///
  /// This property is used to debounce the search query entered by the user in
  /// the search bar. It is used by the [debounce] method to debounce the query
  /// and prevent the search results from updating too frequently.
  Duration _debounceDuration = const Duration(milliseconds: 1000);

  /// Returns the current search query as a [String].
  ///
  /// This method overrides the [build] method in the generated [_$SearchQuery]
  /// class. It returns by default an empty string, but can be overridden to
  /// return the current search query.
  @override
  String build() {
    ref.onDispose(() {
      EasyDebounce.cancel(_debounceKey);
    });

    return '';
  }

  /// Debounces the query by [_debounceDuration] and updates the query state.
  ///
  /// This method is used to debounce the query entered by the user in the
  /// search bar. It takes a [String] parameter representing the new query.
  ///
  /// When the method is called, it cancels any previous debounce timer and
  /// starts a new one with the given duration. When the timer completes, it
  /// updates the state with the new query.
  ///
  /// This method is used to prevent the search results from updating too
  /// frequently as the user types in the search bar.
  void debounce(String query) {
    if (query.isEmpty) {
      clear();
      return;
    }

    ref.read(isSearchLoadingProvider.notifier).set(true);
    EasyDebounce.debounce(_debounceKey, _debounceDuration, () {
      // CardsListController will listen to this provider and rebuild the UI
      state = query;
      ref.read(isSearchLoadingProvider.notifier).set(false);
    });
  }

  /// Fires the debounce timer for the current debounced query.
  ///
  /// When the method is called, it fires the debounce timer for the query. This
  /// causes the debounce timer to complete immediately and update the search
  /// results with the current query.
  ///
  /// This method is used to update the search results immediately when the user
  /// submits the search query, rather than waiting for the debounce timer to
  /// complete.
  void fire() {
    EasyDebounce.fire(_debounceKey);
  }

  /// Clears the query and cancels the debounce timer.
  ///
  /// This method is used to clear the query entered by the user in the search
  /// bar and cancel the debounce timer. It sets the `state` to an empty string
  /// and cancels the debounce timer associated with the `_debounceKey`.
  ///
  /// This method is used to reset the search bar and cancel any pending
  /// debounce timers when the user cancels the search or navigates away from
  /// the search screen.
  void clear() {
    state = '';
    EasyDebounce.cancel(_debounceKey);
    ref.read(isSearchLoadingProvider.notifier).set(false);
    ref.read(searchTextFieldControllerProvider).clear();
  }

  /// Sets the debounce duration for testing purposes.
  ///
  /// This method is used to set the debounce duration for testing purposes. It
  /// takes a [Duration] parameter representing the new debounce duration.
  ///
  /// This method is used to test the debounce functionality of the search bar
  /// by setting a custom debounce duration and verifying that the debounce
  /// timer works as expected.
  @visibleForTesting
  void setDebounceDuration(Duration duration) {
    _debounceDuration = duration;
  }
}

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
@Riverpod(keepAlive: true)
class IsSearchLoading extends _$IsSearchLoading {
  /// Returns a boolean value indicating whether the search is loading.
  ///
  /// This method overrides the `build` method in the generated
  /// [_$IsSearchLoading] class. It returns a boolean value indicating whether
  /// the search is currently loading.
  ///
  /// If the value is `true`, the search is currently loading. If the value is
  /// `false`, the search is not currently loading.
  @override
  bool build() {
    return false;
  }

  /// Sets the loading state of the search.
  ///
  /// This method sets the loading state of the search to the given `value`. If
  /// the value is `true`, the search is currently loading. If the value is
  /// `false`, the search is not currently loading.
  void set(bool value) {
    state = value;
  }
}
