// import '../../../../core/constants/enums.dart';

import 'package:workouts_reminder_client/workouts_reminder_client.dart'
    show WeekSchedule;

import '../../../../core/constants/enums.dart';
import 'day_schedule_model.dart';

class WeekScheduleModel {
  final int? id;
  final List<DayScheduleModel> days;
  final DateTime createdAt;
  final DateTime deadline;
  final String? note;

  bool get isCompleted {
    final now = DateTime.now();
    return now.isAfter(deadline);
  }

  List<int> get todayNotificationIds {
    final today = DateTime.now().weekday;
    return notificationIdsForDay(WeekdayEnum.fromDateTimeWeekday(today));
  }

  List<int> notificationIdsForDay(WeekdayEnum day) {
    final daySchedule = days[day.index];
    if (daySchedule.notifications == null) return [];
    return daySchedule.notifications!.map((e) => e.id).toList();
  }

  WeekdayEnum get todayEnum {
    final today = DateTime.now().weekday;
    return WeekdayEnum.fromDateTimeWeekday(today);
  }

  WeekScheduleModel setTodayStatusEnum(DayWorkoutStatusEnum status) {
    final today = DateTime.now().weekday;
    return setDayStatus(WeekdayEnum.fromDateTimeWeekday(today), status);
  }

  WeekScheduleModel setDayStatus(WeekdayEnum day, DayWorkoutStatusEnum status) {
    days[day.index] = days[day.index].copyWith(status: status);
    return copyWith(days: days);
    // return this;
  }

  DayWorkoutStatusEnum getTodayStatusEnum() {
    final today = DateTime.now().weekday;
    return days[today - 1].status;
  }

  WeekScheduleModel({
    this.id,
    required this.days,
    required this.createdAt,
    required this.deadline,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'note': note,
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
    );
  }

  WeekScheduleModel copyWith({
    List<DayScheduleModel>? days,
    DateTime? createdAt,
    DateTime? deadline,
    String? note,
  }) {
    return WeekScheduleModel(
      days: days ?? this.days,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      note: note ?? this.note,
    );
  }

  factory WeekScheduleModel.init() {
    return WeekScheduleModel(
      days: WeekdayEnum.values
          .map((day) => DayScheduleModel.init(day))
          .toList(),
      note: null,
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 7)),
    );
  }

  factory WeekScheduleModel.forWorkoutDays({
    required Set<WeekdayEnum> workoutDays,
    DateTime? createdAt,
    Duration duration = const Duration(days: 7),
    String? note,
  }) {
    final created = createdAt ?? DateTime.now();
    final deadline = created.add(duration);

    return WeekScheduleModel(
      days: WeekdayEnum.values.map((day) {
        return DayScheduleModel.forWorkoutDay(
          day: day,
          status: workoutDays.contains(day)
              ? DayWorkoutStatusEnum.pending
              : DayWorkoutStatusEnum.notScheduled,
        );
      }).toList(),
      createdAt: created,
      deadline: deadline,
      note: note,
    );
  }

  WeekSchedule toServerSchedule() {
    return WeekSchedule(
      days: days.map((day) => day.toServerDaySchedule()).toList(),
      deadline: deadline,
      note: note,
    );
  }

  factory WeekScheduleModel.fromServerWeekSchedule(
    WeekSchedule weekSchedule,
  ) {
    final days = weekSchedule.days!
        .map((day) => DayScheduleModel.fromServerDaySchedule(day))
        .toList()
      ..sort(
        (a, b) => a.day.index.compareTo(b.day.index),
      );
    return WeekScheduleModel(
      id: weekSchedule.id,
      days: days,
      createdAt: weekSchedule.createdAt,
      deadline: weekSchedule.deadline,
      note: weekSchedule.note,
    );
  }
}
