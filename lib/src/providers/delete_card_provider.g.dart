// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteCardControllerHash() =>
    r'4200217518f4cdadf8017cbd72d3a93bd1c74819';

/// `DeleteCardController` provides a mechanism to manage card deletions in an
/// Anki session.
///
/// This controller maintains an internal queue of pending deletion requests to
/// the database and provides methods to delete and undo delete operations on
/// AnkiCards.
///
/// It immediately removes the card from the local cache (`cardsListProvider`)
/// upon a deletion request, to give a responsive feel to the user. The actual
/// deletion from the database is then queued and performed asynchronously.
///
/// The controller also remembers the last deleted card, allowing for an undo
/// operation.
///
/// Copied from [DeleteCardController].
@ProviderFor(DeleteCardController)
final deleteCardControllerProvider =
    NotifierProvider<DeleteCardController, void>.internal(
  DeleteCardController.new,
  name: r'deleteCardControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteCardControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteCardController = Notifier<void>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
