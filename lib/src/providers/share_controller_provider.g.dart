// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shareControllerHash() => r'99b4c9dde7ad205f40db5c98377ba8a10ab2a86b';

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

abstract class _$ShareController
    extends BuildlessAutoDisposeNotifier<ShareState> {
  late final String sessionId;

  ShareState build(
    String sessionId,
  );
}

/// See also [ShareController].
@ProviderFor(ShareController)
const shareControllerProvider = ShareControllerFamily();

/// See also [ShareController].
class ShareControllerFamily extends Family<ShareState> {
  /// See also [ShareController].
  const ShareControllerFamily();

  /// See also [ShareController].
  ShareControllerProvider call(
    String sessionId,
  ) {
    return ShareControllerProvider(
      sessionId,
    );
  }

  @override
  ShareControllerProvider getProviderOverride(
    covariant ShareControllerProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'shareControllerProvider';
}

/// See also [ShareController].
class ShareControllerProvider
    extends AutoDisposeNotifierProviderImpl<ShareController, ShareState> {
  /// See also [ShareController].
  ShareControllerProvider(
    String sessionId,
  ) : this._internal(
          () => ShareController()..sessionId = sessionId,
          from: shareControllerProvider,
          name: r'shareControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shareControllerHash,
          dependencies: ShareControllerFamily._dependencies,
          allTransitiveDependencies:
              ShareControllerFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  ShareControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  ShareState runNotifierBuild(
    covariant ShareController notifier,
  ) {
    return notifier.build(
      sessionId,
    );
  }

  @override
  Override overrideWith(ShareController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShareControllerProvider._internal(
        () => create()..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ShareController, ShareState>
      createElement() {
    return _ShareControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShareControllerProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShareControllerRef on AutoDisposeNotifierProviderRef<ShareState> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _ShareControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ShareController, ShareState>
    with ShareControllerRef {
  _ShareControllerProviderElement(super.provider);

  @override
  String get sessionId => (origin as ShareControllerProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
