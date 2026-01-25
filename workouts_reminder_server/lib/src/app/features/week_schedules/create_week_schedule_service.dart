import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../notifications/ai_notification_service.dart';

class CreateWeekScheduleService {
  const CreateWeekScheduleService();

  static const AiNotificationService _aiNotificationService =
      AiNotificationService();

  Future<int> call(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    final userId = _requireUserId(session);
    await _requireMotivation(session, userId);
    final progress = await _requireProgress(session, userId);

    // Check if there's an active week schedule
    await _requireNoActiveWeek(session, progress);

    final plannedCopies = await _aiNotificationService.generatePlannedCopies(
      session,
      weekSchedule,
    );
    final weekScheduleId = await session.db.transaction<int>((
      transaction,
    ) async {
      final progressId = progress.id;
      if (progressId == null) {
        throw ServerpodException(
          message: 'Progress ID is missing.',
          errorCode: 500,
        );
      }
      await _touchProgress(
        session,
        progress,
        transaction,
      );

      final insertedWeek = await _insertWeekSchedule(
        session,
        weekSchedule,
        progressId,
        transaction,
      );

      await _insertDaysAndNotifications(
        session,
        insertedWeek,
        weekSchedule.days,
        plannedCopies,
        transaction,
      );

      if (insertedWeek.id == null) {
        throw ServerpodException(
          message: 'Week schedule ID is missing.',
          errorCode: 500,
        );
      }

      return insertedWeek.id!;
    });

    return weekScheduleId;
  }

  Future<int> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) => call(session, weekSchedule);

  UuidValue _requireUserId(Session session) {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw ServerpodException(
        message: 'User is not authenticated.',
        errorCode: 401,
      );
    }

    return UuidValue.withValidation(authInfo.userIdentifier);
  }

  Future<Progress?> _findProgress(
    Session session,
    UuidValue userId, [
    Transaction? transaction,
  ]) {
    return Progress.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      transaction: transaction,
    );
  }

  Future<Progress> _requireProgress(
    Session session,
    UuidValue userId, [
    Transaction? transaction,
  ]) async {
    final existingProgress = await _findProgress(
      session,
      userId,
      transaction,
    );

    if (existingProgress == null) {
      throw ServerpodException(
        message: 'Progress row is missing for user.',
        errorCode: 404,
      );
    }

    if (transaction == null) {
      return existingProgress;
    }

    return _touchProgress(
      session,
      existingProgress,
      transaction,
    );
  }

  Future<Progress> _touchProgress(
    Session session,
    Progress existingProgress,
    Transaction transaction,
  ) {
    final updatedProgress = existingProgress.copyWith(
      updatedAt: DateTime.now(),
    );

    return Progress.db.updateRow(
      session,
      updatedProgress,
      columns: (t) => [t.updatedAt],
      transaction: transaction,
    );
  }

  Future<void> _requireMotivation(
    Session session,
    UuidValue userId, [
    Transaction? transaction,
  ]) async {
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      transaction: transaction,
    );

    final motivation = profile?.motivation.trim() ?? '';
    if (motivation.isEmpty) {
      throw ServerpodException(
        message: 'Please add your motivation before creating a schedule.',
        errorCode: 422,
      );
    }
  }

  Future<void> _requireNoActiveWeek(
    Session session,
    Progress progress,
  ) async {
    // Load the progress with weeks to check for active schedules
    final progressWithWeeks = await Progress.db.findById(
      session,
      progress.id!,
      include: Progress.include(
        weeks: WeekSchedule.includeList(),
      ),
    );

    if (progressWithWeeks?.weeks == null || progressWithWeeks!.weeks!.isEmpty) {
      // No weeks exist, so it's safe to create a new one
      return;
    }

    final now = DateTime.now();

    // Check if any week is unfinished (note is null) and hasn't passed its deadline
    for (final week in progressWithWeeks.weeks!) {
      // A week is considered "active" if:
      // 1. It hasn't been finished (note is null)
      // 2. Current date is on or before the deadline
      if (week.note == null && !now.isAfter(week.deadline)) {
        // Found an active, unfinished week
        final deadlineStr = _formatDate(week.deadline);
        throw ServerpodException(
          message:
              'You already have an active week schedule until $deadlineStr. Please finish your current week before creating a new one.',
          errorCode: 409, // Conflict
        );
      }
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<WeekSchedule> _insertWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
    int progressId,
    Transaction transaction,
  ) {
    final row = WeekSchedule(
      progressId: progressId,
      deadline: weekSchedule.deadline,
      note: null,
      updatedAt: DateTime.now(),
    );

    return WeekSchedule.db.insertRow(
      session,
      row,
      transaction: transaction,
    );
  }

  Future<void> _insertDaysAndNotifications(
    Session session,
    WeekSchedule weekSchedule,
    List<DaySchedule>? days,
    List<NotificationCopy> plannedCopies,
    Transaction transaction,
  ) async {
    if (days == null || days.isEmpty) {
      return;
    }

    final weekScheduleId = weekSchedule.id;
    if (weekScheduleId == null) {
      throw ServerpodException(
        message: 'Week schedule ID is missing.',
        errorCode: 500,
      );
    }

    var copyIndex = 0;
    for (final day in days) {
      final insertedDay = await _insertDaySchedule(
        session,
        day,
        weekScheduleId,
        transaction,
      );

      copyIndex = await _insertNotifications(
        session,
        insertedDay.id,
        day.notifications,
        plannedCopies,
        copyIndex,
        transaction,
      );
    }
  }

  Future<DaySchedule> _insertDaySchedule(
    Session session,
    DaySchedule daySchedule,
    int weekScheduleId,
    Transaction transaction,
  ) {
    final row = DaySchedule(
      weekScheduleId: weekScheduleId,
      day: daySchedule.day,
      status: daySchedule.status,
      updatedAt: DateTime.now(),
    );

    return DaySchedule.db.insertRow(
      session,
      row,
      transaction: transaction,
    );
  }

  Future<int> _insertNotifications(
    Session session,
    int? dayScheduleId,
    List<Notification>? notifications,
    List<NotificationCopy> plannedCopies,
    int copyIndex,
    Transaction transaction,
  ) async {
    if (notifications == null || notifications.isEmpty) {
      return copyIndex;
    }

    if (dayScheduleId == null) {
      throw ServerpodException(
        message: 'Day schedule ID is missing.',
        errorCode: 500,
      );
    }

    final rows = <Notification>[];
    for (final notification in notifications) {
      if (copyIndex >= plannedCopies.length) {
        throw ServerpodException(
          message: 'AI notification count mismatch.',
          errorCode: 500,
        );
      }

      final copy = plannedCopies[copyIndex];
      rows.add(
        Notification(
          dayScheduleId: dayScheduleId,
          title: copy.title,
          body: copy.body,
          scheduledDate: notification.scheduledDate,
          payload: notification.payload,
          updatedAt: DateTime.now(),
        ),
      );
      copyIndex++;
    }

    await Notification.db.insert(
      session,
      rows,
      transaction: transaction,
    );

    return copyIndex;
  }
}
