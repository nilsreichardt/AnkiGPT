import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memory_output_provider.g.dart';

/// A provider that provides a [MemoryOutput] instance.
///
/// The memory output buffers events by the [Logger]. It can be used to access
/// the events later, e. g. to send them to the contact via mail.
@riverpod
MemoryOutput memoryOutput(MemoryOutputRef ref) => MemoryOutput(bufferSize: 200);
