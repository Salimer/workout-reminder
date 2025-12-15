import 'package:timezone/timezone.dart';

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final TZDateTime scheduledDate;
  final String? payload;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledDate,
    this.payload,
  });

  factory NotificationModel.init() {
    final scheduledDate = TZDateTime.now(local).add(const Duration(seconds: 5));
    return NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Workout Reminder',
      body: 'Time for your scheduled workout!',
      scheduledDate: scheduledDate,
      payload: 'workout_reminder_payload',
    );
  }
}
