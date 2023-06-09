// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_output_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memoryOutputHash() => r'81dfa53f17e9dc4bf3c21177e6996f0d089ad0f5';

/// A provider that provides a [MemoryOutput] instance.
///
/// The memory output buffers events by the [Logger]. It can be used to access
/// the events later, e. g. to send them to the contact via mail.
///
/// Copied from [memoryOutput].
@ProviderFor(memoryOutput)
final memoryOutputProvider = AutoDisposeProvider<MemoryOutput>.internal(
  memoryOutput,
  name: r'memoryOutputProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$memoryOutputHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MemoryOutputRef = AutoDisposeProviderRef<MemoryOutput>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
