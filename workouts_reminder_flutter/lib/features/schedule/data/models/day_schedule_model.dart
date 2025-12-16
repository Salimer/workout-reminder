import '../../../../core/constants/enums.dart';
import '../../../notifications/data/models/notification_model.dart';

class DayScheduleModel {
  final WeekdayEnum day;
  final bool hasWorkout;
  final List<NotificationModel>? notifications;

  DayScheduleModel({
    required this.day,
    required this.hasWorkout,
    this.notifications,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day.toString(),
      'hasWorkout': hasWorkout,
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
      hasWorkout: json['hasWorkout'],
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
      hasWorkout: false,
      notifications: [],
    );
  }
}
