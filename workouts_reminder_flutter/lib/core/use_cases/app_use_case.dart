import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart'
    as server;

import '../../features/home/use_cases/bottom_navigation_use_case.dart';
import '../../features/notifications/data/models/notification_model.dart';
import '../../features/profile/data/models/profile_model.dart';
import '../../features/profile/presentation/state/profile_state.dart';
import '../../features/progress/data/models/progress_model.dart';
import '../../features/schedule/data/models/week_schedule_model.dart';
import '../../features/progress/presentation/state/progress_state.dart';
import '../../features/schedule/use_cases/notifications_use_case.dart';

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

    final scheduleWithWeekId = await client.weekSchedule.createWeekSchedule(
      schedule.toServerSchedule(),
    );

    if (scheduleWithWeekId == null) {
      throw Exception('Failed to create week schedule on server.');
    }

    ref.read(bottomNavigationUseCaseProvider).goToMainView();
    await Future.delayed(const Duration(milliseconds: 100));

    final returnedSchedual = WeekScheduleModel.fromServerWeekSchedule(
      scheduleWithWeekId,
    );

    ref
        .read(progressStateProvider.notifier)
        .createWeekSchedule(returnedSchedual);

    await ref
        .read(
          notificationsUseCaseProvider,
        )
        .scheduleWeekNotifications(returnedSchedual);
  }

  Future<void> clearWeekPlan() async {
    final updatedProgress = await ref
        .read(clientProvider)
        .weekSchedule
        .deleteWeekSchedule(DateTime.now());

    if (updatedProgress == null) {
      throw Exception(
        'Failed to retrieve updated progress after deleting week schedule.',
      );
    }

    await ref.read(notificationsUseCaseProvider).clearWeekNotifications();

    ref
        .read(progressStateProvider.notifier)
        .set(
          ProgressModel.fromServerProgress(
            updatedProgress,
          ),
        );
  }

  Future<void> skipTodayWorkout() async {
    await _updateTodayStatus(
      DayWorkoutStatusEnum.skipped,
    );
    await ref.read(notificationsUseCaseProvider).clearTodayNotifications();
  }

  Future<void> performTodayWorkout() async {
    await _updateTodayStatus(
      DayWorkoutStatusEnum.performed,
    );
    await ref.read(notificationsUseCaseProvider).clearTodayNotifications();
  }

  Future<void> resetTodayWorkout() async {
    await _updateTodayStatus(
      DayWorkoutStatusEnum.pending,
    );
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

  Future<void> finishWeek(String note) async {
    final updatedProgress = await ref
        .read(clientProvider)
        .weekSchedule
        .finishWeek(note, DateTime.now());

    if (updatedProgress == null) {
      throw Exception('Failed to finish week on server.');
    }

    ref
        .read(progressStateProvider.notifier)
        .set(ProgressModel.fromServerProgress(updatedProgress));
  }

  Future<void> syncNotifications() async {
    final isSynced = await _areNotificationsSynced();
    debugPrint("Notifications are synced");
    if (isSynced) return;

    final progress = ref.read(progressStateProvider).requireValue;
    final activeWeek = progress.activeWeek;
    if (activeWeek == null) return;

    // If not synced, we clear everything and re-schedule to ensure consistency.
    await ref.read(notificationsUseCaseProvider).clearWeekNotifications();
    await ref
        .read(notificationsUseCaseProvider)
        .scheduleWeekNotifications(
          activeWeek,
        );
  }

  Future<void> _updateTodayStatus(
    DayWorkoutStatusEnum status,
  ) async {
    final updatedProgress = await ref
        .read(clientProvider)
        .daySchedule
        .updateTodayStatus(
          server.DayWorkoutStatusEnum.fromJson(status.name),
          DateTime.now(),
        );

    if (updatedProgress == null) {
      throw Exception('Failed to update today status on server.');
    }

    ref
        .read(progressStateProvider.notifier)
        .set(ProgressModel.fromServerProgress(updatedProgress));
  }

  Future<bool> _areNotificationsSynced() async {
    final ProgressModel progress = ref.read(progressStateProvider).requireValue;
    final List<PendingNotificationRequest> scheduledNotifications = await ref
        .read(notificationsUseCaseProvider)
        .getPendingNotifications();

    final activeWeek = progress.activeWeek;
    if (activeWeek == null) {
      // If no active week, we expect 0 notifications.
      return scheduledNotifications.isEmpty;
    }

    final now = DateTime.now();
    final expectedNotifications = <NotificationModel>[];

    for (final day in activeWeek.days) {
      if (day.notifications == null) continue;
      for (final notification in day.notifications!) {
        // We only care about notifications that should happen in the future.
        // Or perhaps notifications that haven't fired yet.
        // Flutter Local Notifications "pending" list only contains future scheduled items.
        if (notification.scheduledDate.isAfter(now)) {
          expectedNotifications.add(notification);
        }
      }
    }

    if (scheduledNotifications.length != expectedNotifications.length) {
      return false;
    }

    // Create a map of pending notifications for faster lookup
    final pendingMap = {for (final n in scheduledNotifications) n.id: n};

    for (final expected in expectedNotifications) {
      final pending = pendingMap[expected.id];
      if (pending == null) {
        return false; // Expected notification not found in pending list
      }

      // Check content needed for exact match
      // Note: pending.body might be truncated or differ slightly if logic changed,
      // but payload and title should match.
      if (pending.title != expected.title ||
          pending.body != expected.body ||
          pending.payload != expected.payload) {
        return false;
      }
    }

    return true;
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

final finishWeekMutation = Mutation<void>(
  label: 'finish_week',
);

final syncNotificationsMutation = Mutation<void>(
  label: 'sync_notifications',
);
