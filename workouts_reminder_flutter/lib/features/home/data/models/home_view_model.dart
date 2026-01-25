import '../../../../../core/constants/enums.dart';
import '../../../schedule/data/models/day_schedule_model.dart';

class HomeViewModel {
  final String greeting;
  final String userName;
  final int streakDays; // Keeping total completed days
  final WeekdayEnum? nextWorkoutDay;
  final bool isNotificationsEnabled;
  final List<DayScheduleModel> currentWeekDays;
  final List<String> goals;
  final DateTime? weekStartDate;

  const HomeViewModel({
    required this.greeting,
    required this.userName,
    required this.streakDays,
    this.nextWorkoutDay,
    this.isNotificationsEnabled = true,
    required this.currentWeekDays,
    required this.goals,
    this.weekStartDate,
  });
}
