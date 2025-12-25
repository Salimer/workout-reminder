import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../../schedule/presentation/state/week_schedule.dart';

part 'workout_use_case.g.dart';

@Riverpod(keepAlive: true)
WorkoutUseCase workoutUseCase(Ref ref) => WorkoutUseCase(ref);

class WorkoutUseCase {
  final Ref ref;
  WorkoutUseCase(this.ref);

  void performWorkoutAction() {
    ref
        .read(weekScheduleProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.performed);
  }

  void skipDayWorkout() {
    ref
        .read(weekScheduleProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.skipped);
  }

  void resetDayWorkout() {
    ref
        .read(weekScheduleProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.pending);
  }

  void unScheduleDayWorkout() {
    ref
        .read(weekScheduleProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.notScheduled);
  }
}
