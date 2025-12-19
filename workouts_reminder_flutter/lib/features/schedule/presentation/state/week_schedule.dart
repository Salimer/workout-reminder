import 'dart:convert';

import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/local_storage.dart';
import '../../data/models/week_schedule_model.dart';

part 'week_schedule.g.dart';

@Riverpod(keepAlive: true)
class WeekSchedule extends _$WeekSchedule {
  @override
  FutureOr<WeekScheduleModel> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'week_schedule',
      options: const StorageOptions(
        cacheTime: StorageCacheTime(Duration(days: 7)),
        destroyKey: '1.0.1-add-created-deadline',
      ),
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => WeekScheduleModel.fromJson(jsonDecode(data)),
    ).future;
    return state.value ?? WeekScheduleModel.init();
  }

  void set(WeekScheduleModel data) {
    state = AsyncValue.data(data);
  }

  void clear() {
    state = AsyncValue.data(WeekScheduleModel.init());
  }
}
