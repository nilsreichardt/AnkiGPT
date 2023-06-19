// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'b3c351d994b0cd34a8398ab20734f75da70d3d29';

/// See also [SearchQuery].
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

/// See also [IsSearchLoading].
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
