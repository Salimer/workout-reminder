import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/providers/client.dart';
import '../../../../core/providers/local_storage.dart';
import '../../data/models/progress_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';

part 'progress_state.g.dart';

@Riverpod(keepAlive: true)
class ProgressState extends _$ProgressState {
  @override
  FutureOr<ProgressModel> build() async {
    persist(
      ref.watch(localStorageProvider.future),
      key: 'progress_state',
      options: const StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: '1.0.4-add-day-status',
        // destroyKey: '1.0.2-add-created-deadline',
      ),
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => ProgressModel.fromJson(jsonDecode(data)),
    );

    return _fetchedProgress();

    // return state.value ?? ProgressModel.init();
  }

  Future<ProgressModel> _fetchedProgress() async {
    final schedule = await ref.read(clientProvider).progress.getProgress();

    if (schedule == null) {
      throw Exception('No progress data found from server');
    }

    final usableSchedule = ProgressModel.fromServerProgress(schedule);
    return usableSchedule;
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
