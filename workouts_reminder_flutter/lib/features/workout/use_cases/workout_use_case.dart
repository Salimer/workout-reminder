import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../../schedule/presentation/state/progress.dart';

part 'workout_use_case.g.dart';

@Riverpod(keepAlive: true)
WorkoutUseCase workoutUseCase(Ref ref) => WorkoutUseCase(ref);

class WorkoutUseCase {
  final Ref ref;
  WorkoutUseCase(this.ref);

  void performWorkoutAction() {
    ref
        .read(progressProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.performed);
  }

  void skipDayWorkout() {
    ref
        .read(progressProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.skipped);
  }

  void resetDayWorkout() {
    ref
        .read(progressProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.pending);
  }

  void unScheduleDayWorkout() {
    ref
        .read(progressProvider.notifier)
        .setDayStatus(DayWorkoutStatusEnum.notScheduled);
  }
}
