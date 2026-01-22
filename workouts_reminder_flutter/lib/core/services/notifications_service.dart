import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/notifications/data/models/notification_model.dart';

part 'notifications_service.g.dart';

@Riverpod(keepAlive: true)
NotificationsService notificationsSvc(Ref ref) => NotificationsService();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  debugPrint(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with'
    ' payload: ${notificationResponse.payload}',
  );
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    debugPrint(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}

class NotificationsService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Current time in the configured local timezone.
  tz.TZDateTime get localNow => tz.TZDateTime.now(tz.local);

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Avoid prompting on iOS/macOS at app launch; request later explicitly.
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
    await _configureLocalTimeZone();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    if (kIsWeb || Platform.isLinux) {
      return;
    }

    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));
  }

  Future<void> scheduleNotification(NotificationModel notification) async {
    final scheduledDate = tz.TZDateTime.from(
      notification.scheduledDate,
      tz.local,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      scheduledDate,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      payload: notification.payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<bool> askForPermission() async {
    if (Platform.isAndroid) {
      final androidImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await androidImplementation?.requestExactAlarmsPermission() ??
          false;
    } else if (Platform.isIOS || Platform.isMacOS) {
      final iosImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return await iosImplementation?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    } else {
      return false;
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<List<PendingNotificationRequest>>
  getPendingNotificationRequests() async {
    return flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}
