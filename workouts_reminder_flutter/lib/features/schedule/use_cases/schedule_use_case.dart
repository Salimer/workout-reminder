import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workouts_reminder_flutter/features/workout/use_cases/workout_use_case.dart';

import '../../../core/constants/enums.dart';
import '../data/models/week_schedule_model.dart';
import '../presentation/state/progress.dart';
import 'notifications_use_case.dart';

part 'schedule_use_case.g.dart';

@Riverpod(keepAlive: true)
ScheduleUseCase scheduleUseCase(Ref ref) => ScheduleUseCase(ref);

class ScheduleUseCase {
  final Ref ref;
  ScheduleUseCase(this.ref);

  Future<void> createWeekSchedule(
    Set<WeekdayEnum> selectedDays,
  ) async {
    final schedule = WeekScheduleModel.forWorkoutDays(
      workoutDays: selectedDays,
    );

    await ref
        .read(
          notificationsUseCaseProvider,
        )
        .scheduleWeekNotifications(schedule);

    ref.read(progressProvider.notifier).createWeekSchedule(schedule);
  }

  Future<void> clearWeekPlan() async {
    await ref.read(notificationsUseCaseProvider).clearWeekNotifications();

    ref.read(progressProvider.notifier).clearCurrentWeekPlan();
  }

  Future<void> skipTodayWorkout() async {
    ref.read(workoutUseCaseProvider).skipTodayWorkout();
    await ref.read(notificationsUseCaseProvider).clearTodayNotifications();
  }

  Future<void> performTodayWorkout() async {
    ref.read(workoutUseCaseProvider).performTodayWorkout();
    await ref.read(notificationsUseCaseProvider).clearTodayNotifications();
  }
}

final scheduleWeekPlanMutation = Mutation<void>(
  label: 'schedule_week_plan',
);

final clearWeekPlanMutation = Mutation<void>(
  label: 'clear_week_plan',
);

final changeDayWorkoutStatusMutation = Mutation<void>(
  label: 'skip_today_workout',
);
