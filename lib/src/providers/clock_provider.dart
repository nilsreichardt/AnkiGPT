import 'package:clock/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_provider.g.dart';

@Riverpod(keepAlive: true)
Clock clock(ClockRef ref) {
  return const Clock();
}
