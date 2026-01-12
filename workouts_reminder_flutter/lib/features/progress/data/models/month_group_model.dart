import '../../../schedule/data/models/week_schedule_model.dart';

class MonthGroupModel {
  final DateTime month;
  final List<WeekScheduleModel> weeks;

  const MonthGroupModel({
    required this.month,
    required this.weeks,
  });
}
