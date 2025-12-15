import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:workouts_reminder_flutter/core/services/notifications_service.dart';

import '../../data/models/today_model.dart';

part 'today_workout_status.g.dart';

@riverpod
class TodayWorkoutStatus extends _$TodayWorkoutStatus {
  @override
  FutureOr<TodayWorkoutStatusModel> build() async {
    final notificationsSvc = ref.read(notificationsSvcProvider);
    final now = notificationsSvc.localNow;

    // Simulate some asynchronous operation to determine today's workout status
    await Future.delayed(const Duration(seconds: 1));
    // For demonstration, let's assume the user should work out today
    return TodayWorkoutStatusModel(
      dateTime: tz.TZDateTime.from(now, tz.local),
      shouldWorkout: true,
      didWorkout: false,
    );
  }
}
