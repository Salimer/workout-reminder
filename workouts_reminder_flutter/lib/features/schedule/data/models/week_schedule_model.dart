import '../../../../core/constants/enums.dart';
import 'day_schedule_model.dart';

class WeekScheduleModel {
  final List<DayScheduleModel> days;
  final DateTime createdAt;
  final DateTime deadline;
  final String note;

  WeekScheduleModel({
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

  factory WeekScheduleModel.init() {
    return WeekScheduleModel(
      days: WeekdayEnum.values
          .map((day) => DayScheduleModel.init(day))
          .toList(),
      note: 'week 1',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 7)),
    );
  }
}
