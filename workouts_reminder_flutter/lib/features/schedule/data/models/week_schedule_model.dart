import 'package:timezone/timezone.dart' as tz;

import '../../../../core/constants/enums.dart';
import '../../../notifications/data/models/notification_model.dart';
import 'day_schedule_model.dart';

class WeekScheduleModel {
  final List<DayScheduleModel> days;
  final DateTime createdAt;
  final DateTime deadline;
  final String note;
  final bool isSet;

  bool get isCompleted {
    final now = DateTime.now();
    return now.isAfter(deadline);
  }

  WeekScheduleModel({
    required this.days,
    required this.createdAt,
    required this.deadline,
    required this.note,
    required this.isSet,
  });

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'note': note,
      'isSet': isSet,
    };
  }

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) {
    return WeekScheduleModel(
      days: List<DayScheduleModel>.from(
        (json['days'] as List).map(
          (item) => DayScheduleModel.fromJson(item),
        ),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      deadline: DateTime.parse(json['deadline']),
      note: json['note'],
      isSet: json['isSet'] as bool,
    );
  }

  factory WeekScheduleModel.init() {
    return WeekScheduleModel(
      days: WeekdayEnum.values
          .map((day) => DayScheduleModel.init(day))
          .toList(),
      note: 'week 1',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 7)),
      isSet: false,
    );
  }

  factory WeekScheduleModel.forWorkoutDays({
    required Set<WeekdayEnum> workoutDays,
    DateTime? createdAt,
    Duration duration = const Duration(days: 7),
    String note = 'week 1',
  }) {
    final created = createdAt ?? DateTime.now();
    final deadline = created.add(duration);

    return WeekScheduleModel(
      days: WeekdayEnum.values.map((day) {
        final hasWorkout = workoutDays.contains(day);
        return DayScheduleModel.forWorkoutDay(
          day: day,
          hasWorkout: hasWorkout,
        );
      }).toList(),
      createdAt: created,
      deadline: deadline,
      note: note,
      isSet: true,
    );
  }
}
