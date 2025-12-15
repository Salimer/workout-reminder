import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    await ref.read(notificationsSvcProvider).scheduleNotification(notification);
    // await Future.delayed(const Duration(seconds: 5));
  }
}

final notificationMutation = Mutation<void>(label: 'schedule_notification');
