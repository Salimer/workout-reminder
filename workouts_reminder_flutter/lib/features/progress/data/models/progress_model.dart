import 'package:workouts_reminder_flutter/core/constants/enums.dart';

import '../../../schedule/data/models/week_schedule_model.dart';

class ProgressModel {
  final List<WeekScheduleModel> weeks;

  ProgressModel({
    required this.weeks,
  });

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
