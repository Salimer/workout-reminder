import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_storage.dart';

part 'theme.g.dart';

@Riverpod(keepAlive: true)
class Theme extends _$Theme {
  @override
  FutureOr<ThemeMode> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'theme_mode',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: (state) => state.index.toString(),
      decode: (data) => ThemeMode.values[int.parse(data)],
    ).future;
    return state.value ?? ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = AsyncData(mode);
  }
}
