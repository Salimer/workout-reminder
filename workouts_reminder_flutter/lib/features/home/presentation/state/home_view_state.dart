import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/home_view_model.dart';
import '../../../profile/presentation/state/profile_state.dart';
import '../../../progress/presentation/state/progress_state.dart';
import '../../../../core/constants/enums.dart';

part 'home_view_state.g.dart';

@riverpod
class HomeViewState extends _$HomeViewState {
  @override
  HomeViewModel build() {
    final profile = ref.watch(profileStateProvider).value;
    final progress = ref.watch(progressStateProvider).value;

    final now = DateTime.now();
    final greeting = _getGreeting(now);
    final userName = (profile?.characterName.isNotEmpty ?? false)
        ? profile!.characterName
        : 'Champion';
    final goals = profile?.goals ?? [];

    // Calculate Streak (Total completed days for now)
    final streak = progress?.streak ?? 0;

    // Get Current Week Days or Empty List
    final currentWeekDays = progress?.activeWeek?.days ?? [];

    // Calculate Next Workout
    WeekdayEnum? nextWorkout;
    if (progress?.activeWeek != null) {
      final todayIndex = now.weekday; // 1 = Mon, 7 = Sun
      final days = progress!.activeWeek!.days;

      try {
        final sortedDays = List.from(days)
          ..sort((a, b) => a.day.index.compareTo(b.day.index));

        // Find first day that is AFTER today (or today) that is a workout day.
        final nextDay = sortedDays.firstWhere((d) {
          // Check if day is today or future and has a status other than notScheduled
          return d.day.index >= (todayIndex - 1) &&
              d.status != DayWorkoutStatusEnum.notScheduled &&
              // Optionally exclude performed if we only want *upcoming*
              d.status != DayWorkoutStatusEnum.performed;
        });
        nextWorkout = nextDay.day;
      } catch (_) {
        nextWorkout = null;
      }
    }

    return HomeViewModel(
      greeting: greeting,
      userName: userName,
      streakDays: streak,
      nextWorkoutDay: nextWorkout,
      currentWeekDays: currentWeekDays,
      goals: goals,
    );
  }

  String _getGreeting(DateTime time) {
    final hour = time.hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}
