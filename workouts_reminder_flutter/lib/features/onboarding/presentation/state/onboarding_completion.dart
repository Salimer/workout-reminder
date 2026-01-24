import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/local_storage.dart';

part 'onboarding_completion.g.dart';

@Riverpod(keepAlive: true)
class OnboardingCompletion extends _$OnboardingCompletion {
  @override
  FutureOr<bool> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'onboarding_completed',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: (state) => state.toString(),
      decode: (data) => data == 'true',
    ).future;
    return state.value ?? false;
    // return false;
  }

  void complete() {
    state = const AsyncData(true);
  }
}
