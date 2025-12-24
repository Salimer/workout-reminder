import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../data/models/week_schedule_model.dart';
import '../presentation/state/week_schedule.dart';
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

    ref.read(weekScheduleProvider.notifier).set(schedule);
  }

  Future<void> clearWeekPlan() async {
    await ref.read(notificationsUseCaseProvider).clearWeekNotifications();

    ref.read(weekScheduleProvider.notifier).clear();
  }
}

final scheduleWeekPlanMutation = Mutation<void>(
  label: 'schedule_week_plan',
);

final clearWeekPlan = Mutation<void>(
  label: 'clear_week_plan',
);
