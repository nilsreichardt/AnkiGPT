import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// A provider that provides a [MemoryOutput] instance.
///
/// The memory output buffers events by the [Logger]. It can be used to access
/// the events later, e. g. to send them to the contact via mail.
final memoryOutputProvider = Provider((ref) => MemoryOutput(bufferSize: 200));
