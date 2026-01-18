import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../features/profile/data/models/profile_model.dart';
import '../../features/profile/presentation/state/profile_state.dart';
import '../../features/schedule/data/models/week_schedule_model.dart';
import '../../features/progress/presentation/state/progress_state.dart';
import '../../features/schedule/use_cases/notifications_use_case.dart';
import '../../features/workout/use_cases/workout_use_case.dart';
import '../constants/enums.dart';
import '../providers/client.dart';

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

    final client = ref.read(clientProvider);

    await client.weekSchedule.createWeekSchedule(schedule.toServerSchedule());

    ref.read(progressStateProvider.notifier).createWeekSchedule(schedule);

    await ref
        .read(
          notificationsUseCaseProvider,
        )
        .scheduleWeekNotifications(schedule);
  }

  Future<void> clearWeekPlan() async {
    final weekScheduleId = ref
        .read(progressStateProvider)
        .value
        ?.activeWeek
        ?.id;

    if (weekScheduleId == null) {
      throw Exception('No active week schedule to delete.');
    }
    await ref
        .read(clientProvider)
        .weekSchedule
        .deleteWeekSchedule(weekScheduleId);

    await ref.read(notificationsUseCaseProvider).clearWeekNotifications();

    ref.read(progressStateProvider.notifier).clearCurrentWeekPlan();
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

  Future<void> signOut() async {
    await ref.read(clientProvider).auth.signOutDevice();
  }

  Future<void> deleteAccount() async {
    await ref.read(clientProvider).profile.deleteUser();
    await signOut();
  }

  Future<void> updateProfile(ProfileModel profile) async {
    final updatedProfile = await ref
        .read(clientProvider)
        .profile
        .updateProfile(profile.toServer(ref));
    ref
        .read(profileStateProvider.notifier)
        .set(ProfileModel.fromServerProfile(updatedProfile));
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

final updateProfileMutation = Mutation<void>(
  label: 'update_profile',
);
