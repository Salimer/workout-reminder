import 'package:timezone/timezone.dart';

class TodayWorkoutStatusModel {
  final TZDateTime dateTime;
  final bool shouldWorkout;
  final bool didWorkout;

  TodayWorkoutStatusModel({
    required this.dateTime,
    required this.shouldWorkout,
    required this.didWorkout,
  });

  String get dayName {
    return dateTime.weekday == DateTime.monday
        ? 'Monday'
        : dateTime.weekday == DateTime.tuesday
        ? 'Tuesday'
        : dateTime.weekday == DateTime.wednesday
        ? 'Wednesday'
        : dateTime.weekday == DateTime.thursday
        ? 'Thursday'
        : dateTime.weekday == DateTime.friday
        ? 'Friday'
        : dateTime.weekday == DateTime.saturday
        ? 'Saturday'
        : 'Sunday';
  }
}
