import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// A Observer that logs all Provider changes in a [ProviderContainer].
class ProviderLoggerObserver extends ProviderObserver {
  const ProviderLoggerObserver(this.logger);

  final Logger logger;

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.t(
        'Provider "${provider.name ?? provider.runtimeType}" updated: $newValue');
  }

  @override
  didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger
        .t('Provider "${provider.name ?? provider.runtimeType}" added: $value');
  }

  @override
  didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    logger.t('Provider "${provider.name ?? provider.runtimeType}" disposed');
  }
}
