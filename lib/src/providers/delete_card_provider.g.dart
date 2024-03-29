// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteCardControllerHash() =>
    r'c4927f65610d31eb12210bca5bed0e04cdec5a59';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
