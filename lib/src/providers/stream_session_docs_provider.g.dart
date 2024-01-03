// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_session_docs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamSessionDocsHash() => r'cc7107545c11f6845345ccb1efb0978786f32c7f';

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

/// See also [streamSessionDocs].
@ProviderFor(streamSessionDocs)
const streamSessionDocsProvider = StreamSessionDocsFamily();

/// See also [streamSessionDocs].
class StreamSessionDocsFamily extends Family<AsyncValue<List<SessionDto>>> {
  /// See also [streamSessionDocs].
  const StreamSessionDocsFamily();

  /// See also [streamSessionDocs].
  StreamSessionDocsProvider call({
    DateTime? lastCreatedAt,
  }) {
    return StreamSessionDocsProvider(
      lastCreatedAt: lastCreatedAt,
    );
  }

  @override
  StreamSessionDocsProvider getProviderOverride(
    covariant StreamSessionDocsProvider provider,
  ) {
    return call(
      lastCreatedAt: provider.lastCreatedAt,
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
  String? get name => r'streamSessionDocsProvider';
}

/// See also [streamSessionDocs].
class StreamSessionDocsProvider
    extends AutoDisposeStreamProvider<List<SessionDto>> {
  /// See also [streamSessionDocs].
  StreamSessionDocsProvider({
    DateTime? lastCreatedAt,
  }) : this._internal(
          (ref) => streamSessionDocs(
            ref as StreamSessionDocsRef,
            lastCreatedAt: lastCreatedAt,
          ),
          from: streamSessionDocsProvider,
          name: r'streamSessionDocsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamSessionDocsHash,
          dependencies: StreamSessionDocsFamily._dependencies,
          allTransitiveDependencies:
              StreamSessionDocsFamily._allTransitiveDependencies,
          lastCreatedAt: lastCreatedAt,
        );

  StreamSessionDocsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lastCreatedAt,
  }) : super.internal();

  final DateTime? lastCreatedAt;

  @override
  Override overrideWith(
    Stream<List<SessionDto>> Function(StreamSessionDocsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamSessionDocsProvider._internal(
        (ref) => create(ref as StreamSessionDocsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lastCreatedAt: lastCreatedAt,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<SessionDto>> createElement() {
    return _StreamSessionDocsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamSessionDocsProvider &&
        other.lastCreatedAt == lastCreatedAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lastCreatedAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamSessionDocsRef on AutoDisposeStreamProviderRef<List<SessionDto>> {
  /// The parameter `lastCreatedAt` of this provider.
  DateTime? get lastCreatedAt;
}

class _StreamSessionDocsProviderElement
    extends AutoDisposeStreamProviderElement<List<SessionDto>>
    with StreamSessionDocsRef {
  _StreamSessionDocsProviderElement(super.provider);

  @override
  DateTime? get lastCreatedAt =>
      (origin as StreamSessionDocsProvider).lastCreatedAt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
