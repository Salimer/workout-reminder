import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workouts_reminder_flutter/features/schedule/presentation/state/week_schedule.dart';

import '../../../core/constants/enums.dart';
import '../../../core/providers/local_time_date.dart';
import '../../../core/services/notifications_service.dart';
import '../../notifications/data/models/notification_model.dart';
import '../data/models/day_schedule_model.dart';
import '../data/models/week_schedule_model.dart';

part 'notifications_use_case.g.dart';

@Riverpod(keepAlive: true)
NotificationsUseCase notificationsUseCase(Ref ref) => NotificationsUseCase(ref);

class NotificationsUseCase {
  final Ref ref;
  NotificationsUseCase(this.ref);

  Future<void> scheduleNotification(NotificationModel notification) async {
    if (await ref.read(notificationsSvcProvider).askForPermission()) {
      await ref
          .read(notificationsSvcProvider)
          .scheduleNotification(notification);
    } else {
      throw Exception('Notification permission not granted');
    }
  }

  Future<void> scheduleMultipleNotifications(
    List<NotificationModel> notifications,
  ) async {
    for (final notification in notifications) {
      // Ensure the notification time is not passed yet
      debugPrint("Scheduled notification details: ${notification.toJson()}");
      final now = ref.read(localTimeDateProvider);
      if (notification.scheduledDate.isBefore(now)) continue;
      await scheduleNotification(notification);
    }
  }

  Future<void> scheduleDayNotifications(DayScheduleModel daySchedule) async {
    if (!daySchedule.hasWorkout) return;
    if (daySchedule.notifications == null) return;
    await scheduleMultipleNotifications(daySchedule.notifications!);
  }

  Future<void> scheduleWeekNotifications(WeekScheduleModel weekSchedule) async {
    for (final day in weekSchedule.days) {
      await scheduleDayNotifications(day);
    }
  }

  Future<void> clearWeekNotifications() async {
    final pendingNotifications = await ref
        .read(notificationsSvcProvider)
        .getPendingNotificationRequests();
    for (final notification in pendingNotifications) {
      await ref
          .read(notificationsSvcProvider)
          .cancelNotification(notification.id);
    }
  }

  Future<void> _clearDayNotifications(WeekdayEnum day) async {
    final List<int> ids = ref
        .read(weekScheduleProvider.notifier)
        .getDayNotificationIds(day);
    for (final id in ids) {
      await ref.read(notificationsSvcProvider).cancelNotification(id);
    }
  }

  Future<void> clearTodayNotifications() async {
    final today = ref.read(weekScheduleProvider.notifier).todayEnum;
    await _clearDayNotifications(today);
  }
}
