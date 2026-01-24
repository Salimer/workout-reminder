import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/providers/client.dart';
import '../../../../core/providers/local_storage.dart';
import '../../../home/use_cases/bottom_navigation_use_case.dart';
import '../../data/models/progress_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';

part 'progress_state.g.dart';

@Riverpod(keepAlive: false)
class ProgressState extends _$ProgressState {
  @override
  FutureOr<ProgressModel> build() async {
    final storageFuture = ref.watch(localStorageProvider.future);
    persist(
      storageFuture,
      key: 'progress_state',
      options: const StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: '1.0.4-add-day-status',
      ),
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => ProgressModel.fromJson(jsonDecode(data)),
    );
    debugPrint("ProgressState: build() called, fetching progress...");
    ref.onDispose(() {
    // clean the local storage when the provider is disposed
      debugPrint("ProgressState: Disposed.");
      storageFuture.then((storage) async {
        await storage.delete('progress_state');
      });
    });
    ProgressModel progress;
    try {
      debugPrint("Attempting to fetch progress from server...");
      progress = await _fetchedProgress();
    } catch (_) {
      progress = state.value ?? ProgressModel.init();
    }
    _setBottomNavView(progress);
    return progress;
  }

  Future<ProgressModel> _fetchedProgress() async {
    debugPrint("Starting to fetch progress from server...");
    final schedule = await ref.read(clientProvider).progress.getProgress();

    if (schedule == null) {
      throw Exception('No progress data found from server');
      // return ProgressModel.init();
    }

    final usableSchedule = ProgressModel.fromServerProgress(schedule);
    return usableSchedule;
  }

  void _setBottomNavView(ProgressModel progress) {
    if (progress.activeWeek == null) {
      ref.read(bottomNavigationUseCaseProvider).goToScheduleView();
    }
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
