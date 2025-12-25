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
    final scheduledDate = TZDateTime.now(
      local,
    ).add(const Duration(seconds: 5));
    return NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'Workout Reminder',
      body: 'Time for your scheduled workout!',
      scheduledDate: scheduledDate,
      payload: 'workout_reminder_payload',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'scheduledDate': scheduledDate.toString(),
      'payload': payload,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      scheduledDate: TZDateTime.parse(
        local,
        json['scheduledDate'],
      ),
      payload: json['payload'],
    );
  }

  factory NotificationModel.forWorkoutDay({
    required int id,
    required TZDateTime scheduledDate,
    required String title,
    required String body,
    required String payload,
  }) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: scheduledDate.toString(),
    );
  }
}
