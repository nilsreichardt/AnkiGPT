// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$generateNotifierHash() => r'e0d363a98bc3a8a327996a484f2af79af0a8bb78';

/// See also [GenerateNotifier].
@ProviderFor(GenerateNotifier)
final generateNotifierProvider =
    NotifierProvider<GenerateNotifier, GenerateState>.internal(
  GenerateNotifier.new,
  name: r'generateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$generateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GenerateNotifier = Notifier<GenerateState>;
String _$pickedFileHash() => r'45c4fe2ce2a186fbae92a34b26b601c8de4f6d6a';

/// See also [PickedFile].
@ProviderFor(PickedFile)
final pickedFileProvider =
    AutoDisposeNotifierProvider<PickedFile, PlatformFile?>.internal(
  PickedFile.new,
  name: r'pickedFileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pickedFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PickedFile = AutoDisposeNotifier<PlatformFile?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
