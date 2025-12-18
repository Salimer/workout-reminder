import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workouts_reminder_flutter/core/providers/local_time_date.dart';
import 'package:workouts_reminder_flutter/features/schedule/data/models/day_schedule_model.dart';

import '../../../core/services/notifications_service.dart';
import '../../notifications/data/models/notification_model.dart';

part 'notifications_controller.g.dart';

@riverpod
NotificationsController notificationsController(Ref ref) =>
    NotificationsController(ref);

class NotificationsController {
  final Ref ref;
  NotificationsController(this.ref);

  Future<void> scheduleNotification(NotificationModel notification) async {
    await ref.read(notificationsSvcProvider).askForPermission();
    await ref.read(notificationsSvcProvider).scheduleNotification(notification);
    // await Future.delayed(const Duration(seconds: 5));
  }

  Future<void> scheduleMultipleNotifications(
    List<NotificationModel> notifications,
  ) async {
    for (final notification in notifications) {
      await scheduleNotification(notification);
    }
  }

  Future<void> scheduleDayNotifications(DayScheduleModel daySchedule) async {
    if (!daySchedule.hasWorkout) return;
    if(daySchedule.notifications == null) return;
    for (final notification in daySchedule.notifications!) {
      // Ensure the notification time is not passed yet
      final now = ref.read(localTimeDateProvider);
      if (notification.scheduledDate.isBefore(now)) continue;
      await scheduleNotification(notification);
    }
  }
}

final notificationMutation = Mutation<void>(label: 'schedule_notification');
