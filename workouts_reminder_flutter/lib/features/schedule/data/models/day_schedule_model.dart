import 'package:timezone/timezone.dart' as tz;
import 'package:workouts_reminder_client/workouts_reminder_client.dart'
    show DaySchedule, DayWorkoutStatusEnum, WeekdayEnum;

import '../../../../core/constants/enums.dart' as enums;
import '../../../notifications/data/models/notification_model.dart';

class DayScheduleModel {
  final enums.WeekdayEnum day;
  final List<NotificationModel>? notifications;
  final enums.DayWorkoutStatusEnum status;

  bool get hasWorkout => status != enums.DayWorkoutStatusEnum.notScheduled;
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
      day: enums.WeekdayEnum.values.firstWhere(
        (e) => e.toString() == json['day'],
      ),
      status: enums.DayWorkoutStatusEnum.fromString(json['status']),
      notifications: json['notifications'] != null
          ? List<NotificationModel>.from(
              (json['notifications'] as List).map(
                (item) => NotificationModel.fromJson(item),
              ),
            )
          : null,
    );
  }

  DayScheduleModel copyWith({
    enums.WeekdayEnum? day,
    List<NotificationModel>? notifications,
    enums.DayWorkoutStatusEnum? status,
  }) {
    return DayScheduleModel(
      day: day ?? this.day,
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
    );
  }

  factory DayScheduleModel.init(enums.WeekdayEnum day) {
    return DayScheduleModel(
      day: day,
      notifications: [],
      status: enums.DayWorkoutStatusEnum.notScheduled,
    );
  }

  factory DayScheduleModel.forWorkoutDay({
    required enums.WeekdayEnum day,
    required enums.DayWorkoutStatusEnum status,
  }) {
    return DayScheduleModel(
      day: day,
      status: status,
      notifications: status != enums.DayWorkoutStatusEnum.notScheduled
          ? _buildDayNotifications(
              day: day,
              start: tz.TZDateTime.now(tz.local),
            )
          : null,
    );
  }

  static List<NotificationModel> _buildDayNotifications({
    required enums.WeekdayEnum day,
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
        id: _notificationId(morning, 0),
        title: 'Workout Reminder (Morning)',
        body: '${day.day}: time for your morning workout.',
        scheduledDate: morning,
        payload: 'workout:${day.day}:morning',
      ),
      NotificationModel.forWorkoutDay(
        id: _notificationId(afternoon, 1),
        title: 'Workout Reminder (Afternoon)',
        body: '${day.day}: time for your afternoon workout.',
        scheduledDate: afternoon,
        payload: 'workout:${day.day}:afternoon',
      ),
      NotificationModel.forWorkoutDay(
        id: _notificationId(evening, 2),
        title: 'Workout Reminder (Evening)',
        body: '${day.day}: time for your evening workout.',
        scheduledDate: evening,
        payload: 'workout:${day.day}:evening',
      ),
    ];
  }

  static int _notificationId(tz.TZDateTime date, int slot) {
    final yyyymmdd = date.year * 10000 + date.month * 100 + date.day;
    return (yyyymmdd * 10) + slot;
  }

  static int _asDateTimeWeekday(enums.WeekdayEnum day) {
    switch (day) {
      case enums.WeekdayEnum.monday:
        return DateTime.monday;
      case enums.WeekdayEnum.tuesday:
        return DateTime.tuesday;
      case enums.WeekdayEnum.wednesday:
        return DateTime.wednesday;
      case enums.WeekdayEnum.thursday:
        return DateTime.thursday;
      case enums.WeekdayEnum.friday:
        return DateTime.friday;
      case enums.WeekdayEnum.saturday:
        return DateTime.saturday;
      case enums.WeekdayEnum.sunday:
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

  DaySchedule toServerDaySchedule() {
    return DaySchedule(
      day: WeekdayEnum.fromJson(day.name),
      status: DayWorkoutStatusEnum.fromJson(status.name),
      notifications: notifications
          ?.map((notification) => notification.toServerNotification())
          .toList(),
    );
  }

  factory DayScheduleModel.fromServerDaySchedule(
    DaySchedule daySchedule,
  ) {
    return DayScheduleModel(
      day: enums.WeekdayEnum.fromString(daySchedule.day.name),
      status: enums.DayWorkoutStatusEnum.fromServerStatus(
        daySchedule.status.name,
      ),
      notifications: daySchedule.notifications
          ?.map(
            (notification) =>
                NotificationModel.fromServerNotification(notification),
          )
          .toList(),
    );
  }
}
