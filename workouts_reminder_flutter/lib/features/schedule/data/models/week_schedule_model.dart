import '../../../../core/constants/enums.dart';
import 'day_schedule_model.dart';

class WeekScheduleModel {
  final List<DayScheduleModel> days;
  final String note;

  WeekScheduleModel({required this.days, required this.note});

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),
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
      note: json['note'],
    );
  }

  factory WeekScheduleModel.init() {
    return WeekScheduleModel(
      days: WeekdayEnum.values
          .map((day) => DayScheduleModel.init(day))
          .toList(),
      note: 'week 1',
    );
  }
}
