import 'package:timezone/timezone.dart' as tz;

import '../../../../core/constants/enums.dart';
import '../../../notifications/data/models/notification_model.dart';

class DayScheduleModel {
  final WeekdayEnum day;
  final List<NotificationModel>? notifications;
  final DayWorkoutStatusEnum status;

  bool get hasWorkout => status != DayWorkoutStatusEnum.notScheduled;

  DayScheduleModel({
    required this.day,
    this.notifications,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day.toString(),
      'status': status.toString(),
      'notifications': notifications
          ?.map((notification) => notification.toJson())
          .toList(),
    };
  }

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      day: WeekdayEnum.values.firstWhere(
        (e) => e.toString() == json['day'],
      ),
      status: DayWorkoutStatusEnum.fromString(json['status']),
      notifications: json['notifications'] != null
          ? List<NotificationModel>.from(
              (json['notifications'] as List).map(
                (item) => NotificationModel.fromJson(item),
              ),
            )
          : null,
    );
  }

  factory DayScheduleModel.init(WeekdayEnum day) {
    return DayScheduleModel(
      day: day,
      notifications: [],
      status: DayWorkoutStatusEnum.notScheduled,
    );
  }

  factory DayScheduleModel.forWorkoutDay({
    required WeekdayEnum day,
    required DayWorkoutStatusEnum status,
  }) {
    return DayScheduleModel(
      day: day,
      status: status,
      notifications: status != DayWorkoutStatusEnum.notScheduled
          ? _buildDayNotifications(
              day: day,
              start: tz.TZDateTime.now(tz.local),
            )
          : null,
    );
  }

  static List<NotificationModel> _buildDayNotifications({
    required WeekdayEnum day,
    required tz.TZDateTime start,
  }) {
    final morning = _nextOccurrence(
      start: start,
      weekday: _asDateTimeWeekday(day),
      hour: 8,
      minute: 0,
    );
    final afternoon = _nextOccurrence(
      start: start,
      weekday: _asDateTimeWeekday(day),
      hour: 13,
      minute: 0,
    );
    final evening = _nextOccurrence(
      start: start,
      weekday: _asDateTimeWeekday(day),
      hour: 19,
      minute: 0,
    );

    return [
      NotificationModel.forWorkoutDay(
        title: 'Workout Reminder (Morning)',
        body: '${day.day}: time for your morning workout.',
        scheduledDate: morning,
        payload: 'workout:${day.day}:morning',
      ),
      NotificationModel.forWorkoutDay(
        title: 'Workout Reminder (Afternoon)',
        body: '${day.day}: time for your afternoon workout.',
        scheduledDate: afternoon,
        payload: 'workout:${day.day}:afternoon',
      ),
      NotificationModel.forWorkoutDay(
        title: 'Workout Reminder (Evening)',
        body: '${day.day}: time for your evening workout.',
        scheduledDate: evening,
        payload: 'workout:${day.day}:evening',
      ),
    ];
  }

  static int _asDateTimeWeekday(WeekdayEnum day) {
    switch (day) {
      case WeekdayEnum.monday:
        return DateTime.monday;
      case WeekdayEnum.tuesday:
        return DateTime.tuesday;
      case WeekdayEnum.wednesday:
        return DateTime.wednesday;
      case WeekdayEnum.thursday:
        return DateTime.thursday;
      case WeekdayEnum.friday:
        return DateTime.friday;
      case WeekdayEnum.saturday:
        return DateTime.saturday;
      case WeekdayEnum.sunday:
        return DateTime.sunday;
    }
  }

  static tz.TZDateTime _nextOccurrence({
    required tz.TZDateTime start,
    required int weekday,
    required int hour,
    required int minute,
  }) {
    final daysUntil = (weekday - start.weekday + 7) % 7;
    final date = start.add(Duration(days: daysUntil));
    var candidate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
    if (candidate.isBefore(start)) {
      candidate = candidate.add(const Duration(days: 7));
    }
    return candidate;
  }
}
