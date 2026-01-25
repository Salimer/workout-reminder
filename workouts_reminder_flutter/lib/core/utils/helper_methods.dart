import '../../../features/schedule/data/models/day_schedule_model.dart';

/// Reorders days to start from the week's creation date.
///
/// For example, if the week started on Sunday, the order will be:
/// Sun, Mon, Tue, Wed, Thu, Fri, Sat
///
/// This ensures the day ordering matches the user's actual week schedule
/// rather than always showing Monday-Sunday.
List<DayScheduleModel> reorderDaysFromWeekStart(
  List<DayScheduleModel> days,
  DateTime weekStartDate,
) {
  if (days.isEmpty) return days;

  // Sort by day index (Mon=0, ..., Sun=6)
  final sortedDays = List<DayScheduleModel>.from(days)
    ..sort((a, b) => a.day.index.compareTo(b.day.index));

  // Get the weekday when the week was created (1 = Mon, ..., 7 = Sun)
  final startWeekday = weekStartDate.weekday;
  // Convert to 0-based index matching WeekdayEnum (0 = Mon, ..., 6 = Sun)
  final startIndex = startWeekday - 1;

  // Reorder: days from startIndex to end, then days from 0 to startIndex
  final reordered = [
    ...sortedDays.sublist(startIndex),
    ...sortedDays.sublist(0, startIndex),
  ];

  return reordered;
}
