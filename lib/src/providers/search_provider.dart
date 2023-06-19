import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  static const _debounceKey = 'search';
  Duration _debounceDuration = const Duration(milliseconds: 1000);

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
  }

  @visibleForTesting
  void setDebounceDuration(Duration duration) {
    _debounceDuration = duration;
  }
}

@Riverpod(keepAlive: true)
class IsSearchLoading extends _$IsSearchLoading {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}
