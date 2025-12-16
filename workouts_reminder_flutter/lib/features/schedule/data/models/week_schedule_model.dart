import 'package:workouts_reminder_flutter/features/schedule/data/models/day_schedule_model.dart';

import '../../../../core/constants/enums.dart';

class WeekScheduleModel {
  final List<DayScheduleModel> days;

  WeekScheduleModel({required this.days});

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),
    };
  }

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) {
    return WeekScheduleModel(
      days: List<DayScheduleModel>.from(
        (json['days'] as List).map(
          (item) => DayScheduleModel.fromJson(item),
        ),
      ),
    );
  }

  factory WeekScheduleModel.init() {
    return WeekScheduleModel(
      days: WeekdayEnum.values
          .map((day) => DayScheduleModel.init(day))
          .toList(),
    );
  }
}
