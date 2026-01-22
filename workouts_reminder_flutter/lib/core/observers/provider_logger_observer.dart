import 'dart:developer' as dev;
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

base class ProviderLoggerObserver extends ProviderObserver {
  String _providerName(ProviderObserverContext context) =>
      context.provider.name ?? context.provider.runtimeType.toString();

  void _log(
    String phase,
    ProviderObserverContext context, {
    String? details,
  }) {
    final mutationLabel =
        context.mutation != null ? ' [mutation: ${context.mutation}]' : '';
    final message =
        '[PROVIDER][$phase] ${_providerName(context)}$mutationLabel${details ?? ''}';
    dev.log(message, name: 'Riverpod');
    // debugPrint(message);
  }

  String _pretty(Object? value) => switch (value) {
        MutationIdle() => 'idle',
        MutationPending() => 'pending',
        MutationSuccess(:final value) => 'success($value)',
        MutationError(:final error, :final stackTrace) =>
          'error($error)\n$stackTrace',
        _ => value?.toString() ?? 'null',
      };

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _log('add', context, details: ' -> ${_pretty(value)}');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    _log(
      'update',
      context,
      details: ' ${_pretty(previousValue)} -> ${_pretty(newValue)}',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    _log('error', context, details: ' $error\n$stackTrace');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _log('dispose', context);
  }

  @override
  void mutationStart(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    _log('mutation-start', context);
  }

  @override
  void mutationSuccess(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object? result,
  ) {
    _log('mutation-success', context, details: ' -> ${_pretty(result)}');
  }

  @override
  void mutationError(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object error,
    StackTrace stackTrace,
  ) {
    _log('mutation-error', context, details: ' $error\n$stackTrace');
  }

  @override
  void mutationReset(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    _log('mutation-reset', context);
  }
}
