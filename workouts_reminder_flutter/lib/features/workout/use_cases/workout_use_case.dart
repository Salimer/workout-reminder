import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../../progress/presentation/state/progress_state.dart';

part 'workout_use_case.g.dart';

@Riverpod(keepAlive: true)
WorkoutUseCase workoutUseCase(Ref ref) => WorkoutUseCase(ref);

class WorkoutUseCase {
  final Ref ref;
  WorkoutUseCase(this.ref);

  void performTodayWorkout() {
    ref
        .read(progressStateProvider.notifier)
        .setTodayStatus(DayWorkoutStatusEnum.performed);
  }

  void skipTodayWorkout() {
    ref
        .read(progressStateProvider.notifier)
        .setTodayStatus(DayWorkoutStatusEnum.skipped);
  }

  void resetTodayWorkout() {
    ref
        .read(progressStateProvider.notifier)
        .setTodayStatus(DayWorkoutStatusEnum.pending);
  }

  void unScheduleTodayWorkout() {
    ref
        .read(progressStateProvider.notifier)
        .setTodayStatus(DayWorkoutStatusEnum.notScheduled);
  }
}
