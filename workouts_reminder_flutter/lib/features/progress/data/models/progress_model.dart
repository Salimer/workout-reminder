import 'package:workouts_reminder_flutter/core/constants/enums.dart';

import '../../../schedule/data/models/week_schedule_model.dart';

class ProgressModel {
  final List<WeekScheduleModel> weeks;

  ProgressModel({
    required this.weeks,
  });

  WeekScheduleModel? get activeWeek {
    if (weeks.isEmpty) return null;
    return weeks.reduce(
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

  double get coverage =>
      scheduledDays == 0 ? 0 : completedDays / scheduledDays;

  factory ProgressModel.init() {
    return ProgressModel(weeks: exampleWeeks);
  }
}

List<WeekScheduleModel> exampleWeeks = [
  WeekScheduleModel.forWorkoutDays(
    workoutDays: {
      WeekdayEnum.friday,
      WeekdayEnum.wednesday,
      WeekdayEnum.monday,
    },
    note: 'Week 1: Getting Started',
  ),
  WeekScheduleModel.forWorkoutDays(
    workoutDays: {
      WeekdayEnum.tuesday,
      WeekdayEnum.thursday,
      WeekdayEnum.saturday,
    },
    note: 'Week 2: Building Momentum',
  ),
  WeekScheduleModel.forWorkoutDays(
    workoutDays: {
      WeekdayEnum.monday,
      WeekdayEnum.wednesday,
      WeekdayEnum.friday,
    },
    note: 'Week 3: Pushing Further',
  ),
  WeekScheduleModel.forWorkoutDays(
    workoutDays: {
      WeekdayEnum.tuesday,
      WeekdayEnum.thursday,
      WeekdayEnum.saturday,
    },
    note: 'Week 4: Reaching Goals',
  ),
];
