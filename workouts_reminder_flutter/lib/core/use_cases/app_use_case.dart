import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/schedule/data/models/week_schedule_model.dart';
import '../../features/schedule/presentation/state/progress.dart';
import '../../features/schedule/use_cases/notifications_use_case.dart';
import '../../features/workout/use_cases/workout_use_case.dart';
import '../constants/enums.dart';

part 'app_use_case.g.dart';

@Riverpod(keepAlive: true)
AppUseCase appUseCase(Ref ref) => AppUseCase(ref);

class AppUseCase {
  final Ref ref;
  AppUseCase(this.ref);

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

  Future<void> resetTodayWorkout() async {
    ref.read(workoutUseCaseProvider).resetTodayWorkout();
    await ref.read(notificationsUseCaseProvider).enableTodayNotifications();
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
