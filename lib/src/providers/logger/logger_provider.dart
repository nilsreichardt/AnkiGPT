import 'package:ankigpt/src/providers/logger/memory_output_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// A provider that provides a [Logger] instance.
///
/// The logger instance will be created in the main method.
final loggerProvider = Provider<Logger>((ref) {
  final memoryOutput = ref.watch(memoryOutputProvider);
  return Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 6,
      lineLength: 50,
      colors: false,
    ),
    output: MultiOutput(
      [
        ConsoleOutput(),
        // We store the logs in memory so that we can access them later.
        memoryOutput,
      ],
    ),
  );
});
