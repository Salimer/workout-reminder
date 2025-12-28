import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/providers/local_storage.dart';
import '../../../progress/data/models/progress_model.dart';
import '../../data/models/week_schedule_model.dart';

part 'progress.g.dart';

@Riverpod(keepAlive: true)
class Progress extends _$Progress {
  @override
  FutureOr<ProgressModel> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'progress',
      options: const StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: '1.0.4-add-day-status',
        // destroyKey: '1.0.2-add-created-deadline',
      ),
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => ProgressModel.fromJson(jsonDecode(data)),
    ).future;
    return state.value ?? ProgressModel.init();
  }

  void set(ProgressModel data) {
    state = AsyncValue.data(data);
  }

  void clear() {
    state = AsyncValue.data(ProgressModel.init());
  }

  bool isCurrentWeekSet() {
    final currentState = state.requireValue;
    final activeWeek = currentState.activeWeek;
    if (activeWeek == null) return false;
    return true;
  }

  void setTodayStatus(DayWorkoutStatusEnum status) {
    debugPrint('Setting today status to: $status');
    final currentState = state.requireValue;
    final updatedState = currentState.setTodayStatusOfActiveWeek(
      status,
    );
    debugPrint("Updated state after setting day status: $updatedState");
    if (updatedState != null) {
      set(updatedState);
    }
  }

  void createWeekSchedule(WeekScheduleModel weekSchedule) {
    final currentState = state.requireValue;
    final updatedState = currentState.createWeekSchedule(weekSchedule);
    set(updatedState);
  }

  void clearCurrentWeekPlan() {
    final currentState = state.requireValue;
    final updatedWeeks = currentState.clearCurrentWeekPlan();
    set(updatedWeeks);
  }
}
