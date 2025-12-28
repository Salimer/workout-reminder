import 'package:workouts_reminder_flutter/core/constants/enums.dart';

import '../../../schedule/data/models/day_schedule_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';

class ProgressModel {
  final List<WeekScheduleModel> weeks;

  ProgressModel({
    required this.weeks,
  });

  WeekScheduleModel? get activeWeek {
    if (weeks.isEmpty) return null;
    final now = DateTime.now();
    final currentWeeks = weeks.where(
      (week) => !now.isBefore(week.createdAt) && !now.isAfter(week.deadline),
    );
    if (currentWeeks.isEmpty) return null;
    return currentWeeks.reduce(
      (current, next) =>
          next.createdAt.isAfter(current.createdAt) ? next : current,
    );
  }

  int get totalDays => activeWeek == null ? 0 : WeekdayEnum.values.length;

  int get scheduledDays {
    final week = activeWeek;
    if (week == null) return 0;
    return week.days
        .where((day) => day.status != DayWorkoutStatusEnum.notScheduled)
        .length;
  }

  int get completedDays {
    final week = activeWeek;
    if (week == null) return 0;
    return week.days
        .where((day) => day.status == DayWorkoutStatusEnum.performed)
        .length;
  }

  int get restDays => totalDays - scheduledDays;

  int get plannedWeeks => activeWeek == null ? 0 : 1;

  double get coverage => scheduledDays == 0 ? 0 : completedDays / scheduledDays;

  ProgressModel? setTodayStatusOfActiveWeek(DayWorkoutStatusEnum status) {
    final week = activeWeek;
    if (week == null) return null;
    final updatedWeek = week.setTodayStatusEnum(status);
    final updatedWeeks = weeks.map((w) {
      if (w.createdAt == week.createdAt) {
        return updatedWeek;
      }
      return w;
    }).toList();

    return ProgressModel(weeks: updatedWeeks);
  }

  ProgressModel createWeekSchedule(WeekScheduleModel weekSchedule) {
    final updatedWeeks = [...weeks, weekSchedule];
    return copyWith(weeks: updatedWeeks);
  }

  ProgressModel clearCurrentWeekPlan() {
    final updatedWeeks = weeks
        .where(
          (week) => week != activeWeek,
        )
        .toList();
    return copyWith(weeks: updatedWeeks);
  }

  factory ProgressModel.init() {
    return ProgressModel(weeks: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'weeks': weeks.map((week) => week.toJson()).toList(),
    };
  }

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      weeks: (json['weeks'] as List<dynamic>)
          .map(
            (weekJson) =>
                WeekScheduleModel.fromJson(weekJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  ProgressModel copyWith({
    List<WeekScheduleModel>? weeks,
  }) {
    return ProgressModel(
      weeks: weeks ?? this.weeks,
    );
  }

  factory ProgressModel.initSeedData() {
    return ProgressModel(weeks: seedWeeksFromToday());
  }
}

List<WeekScheduleModel> seedWeeksFromToday() {
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, now.day);
  const pattern = [3, 2, 6, 4, 5, 2];

  return List.generate(52, (index) {
    final workoutCount = pattern[index % pattern.length];
    final week = WeekScheduleModel.forWorkoutDays(
      workoutDays: _workoutDaysForWeek(index, workoutCount),
      createdAt: start.add(Duration(days: 7 * index)),
      note: 'Week ${index + 1}',
    );
    return _applyStatusPattern(week, index);
  });
}

Set<WeekdayEnum> _workoutDaysForWeek(int weekIndex, int count) {
  const baseSets = {
    2: [0, 3],
    3: [0, 2, 4],
    4: [0, 1, 3, 5],
    5: [0, 1, 2, 4, 5],
    6: [0, 1, 2, 3, 4, 5],
  };
  final base = baseSets[count] ?? baseSets[3]!;
  final offset = weekIndex % WeekdayEnum.values.length;

  return base.map((index) => WeekdayEnum.values[(index + offset) % 7]).toSet();
}

WeekScheduleModel _applyStatusPattern(
  WeekScheduleModel week,
  int weekIndex,
) {
  const statusPattern = [
    DayWorkoutStatusEnum.pending,
    DayWorkoutStatusEnum.performed,
    DayWorkoutStatusEnum.skipped,
    DayWorkoutStatusEnum.notScheduled,
  ];

  final updatedDays = <DayScheduleModel>[];
  for (var i = 0; i < week.days.length; i++) {
    final day = week.days[i];
    if (day.status == DayWorkoutStatusEnum.notScheduled) {
      updatedDays.add(day);
      continue;
    }

    final status = statusPattern[(weekIndex + i) % statusPattern.length];
    updatedDays.add(
      day.copyWith(
        status: status,
        notifications: status == DayWorkoutStatusEnum.notScheduled
            ? null
            : day.notifications,
      ),
    );
  }

  return week.copyWith(days: updatedDays);
}
