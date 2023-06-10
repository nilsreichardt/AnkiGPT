// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_feedback_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cardFeedbackStatusControllerHash() =>
    r'f88cd4602e9348ad1855143b34e532fc56e96d71';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CardFeedbackStatusController
    extends BuildlessAutoDisposeNotifier<CardFeedbackStatus> {
  late final String cardId;

  CardFeedbackStatus build(
    String cardId,
  );
}

/// See also [CardFeedbackStatusController].
@ProviderFor(CardFeedbackStatusController)
const cardFeedbackStatusControllerProvider =
    CardFeedbackStatusControllerFamily();

/// See also [CardFeedbackStatusController].
class CardFeedbackStatusControllerFamily extends Family<CardFeedbackStatus> {
  /// See also [CardFeedbackStatusController].
  const CardFeedbackStatusControllerFamily();

  /// See also [CardFeedbackStatusController].
  CardFeedbackStatusControllerProvider call(
    String cardId,
  ) {
    return CardFeedbackStatusControllerProvider(
      cardId,
    );
  }

  @override
  CardFeedbackStatusControllerProvider getProviderOverride(
    covariant CardFeedbackStatusControllerProvider provider,
  ) {
    return call(
      provider.cardId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cardFeedbackStatusControllerProvider';
}

/// See also [CardFeedbackStatusController].
class CardFeedbackStatusControllerProvider
    extends AutoDisposeNotifierProviderImpl<CardFeedbackStatusController,
        CardFeedbackStatus> {
  /// See also [CardFeedbackStatusController].
  CardFeedbackStatusControllerProvider(
    this.cardId,
  ) : super.internal(
          () => CardFeedbackStatusController()..cardId = cardId,
          from: cardFeedbackStatusControllerProvider,
          name: r'cardFeedbackStatusControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cardFeedbackStatusControllerHash,
          dependencies: CardFeedbackStatusControllerFamily._dependencies,
          allTransitiveDependencies:
              CardFeedbackStatusControllerFamily._allTransitiveDependencies,
        );

  final String cardId;

  @override
  bool operator ==(Object other) {
    return other is CardFeedbackStatusControllerProvider &&
        other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  CardFeedbackStatus runNotifierBuild(
    covariant CardFeedbackStatusController notifier,
  ) {
    return notifier.build(
      cardId,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
