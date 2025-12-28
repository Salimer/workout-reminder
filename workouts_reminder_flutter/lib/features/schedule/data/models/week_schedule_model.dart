import '../../../../core/constants/enums.dart';
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

  List<int> get todayNotificationIds {
    final today = DateTime.now().weekday;
    return notificationIdsForDay(WeekdayEnum.values[today - 1]);
  }

  List<int> notificationIdsForDay(WeekdayEnum day) {
    final daySchedule = days[day.index];
    if (daySchedule.notifications == null) return [];
    return daySchedule.notifications!.map((e) => e.id).toList();
  }

  WeekdayEnum get todayEnum {
    final today = DateTime.now().weekday;
    return WeekdayEnum.values[today - 1];
  }

  WeekScheduleModel setTodayStatusEnum(DayWorkoutStatusEnum status) {
    final today = DateTime.now().weekday;
    return setDayStatus(WeekdayEnum.values[today - 1], status);
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

  WeekScheduleModel copyWith({
    List<DayScheduleModel>? days,
    DateTime? createdAt,
    DateTime? deadline,
    String? note,
    bool? isSet,
  }) {
    return WeekScheduleModel(
      days: days ?? this.days,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      note: note ?? this.note,
      isSet: isSet ?? this.isSet,
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
      isSet: true,
    );
  }
}
