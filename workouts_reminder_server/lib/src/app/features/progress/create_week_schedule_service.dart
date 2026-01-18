import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class CreateWeekScheduleService {
  const CreateWeekScheduleService();

  Future<void> call(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    final userId = _requireUserId(session);
    await session.db.transaction((transaction) async {
      final progress = await _requireProgress(
        session,
        userId,
        transaction,
      );

      final progressId = progress.id;
      if (progressId == null) {
        throw StateError('Progress ID is missing.');
      }

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
        transaction,
      );
    });
  }

  Future<void> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) => call(session, weekSchedule);

  UuidValue _requireUserId(Session session) {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('User is not authenticated.');
    }

    return UuidValue.withValidation(authInfo.userIdentifier);
  }

  Future<Progress?> _findProgress(
    Session session,
    UuidValue userId,
    Transaction transaction,
  ) {
    return Progress.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      transaction: transaction,
    );
  }

  Future<Progress> _requireProgress(
    Session session,
    UuidValue userId,
    Transaction transaction,
  ) async {
    final existingProgress = await _findProgress(
      session,
      userId,
      transaction,
    );

    if (existingProgress == null) {
      throw StateError('Progress row is missing for user.');
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
    final updatedProgress =
        existingProgress.copyWith(updatedAt: DateTime.now());

    return Progress.db.updateRow(
      session,
      updatedProgress,
      columns: (t) => [t.updatedAt],
      transaction: transaction,
    );
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
      note: weekSchedule.note,
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
    Transaction transaction,
  ) async {
    if (days == null || days.isEmpty) {
      return;
    }

    final weekScheduleId = weekSchedule.id;
    if (weekScheduleId == null) {
      throw StateError('Week schedule ID is missing.');
    }

    for (final day in days) {
      final insertedDay = await _insertDaySchedule(
        session,
        day,
        weekScheduleId,
        transaction,
      );

      await _insertNotifications(
        session,
        insertedDay.id,
        day.notifications,
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

  Future<void> _insertNotifications(
    Session session,
    int? dayScheduleId,
    List<Notification>? notifications,
    Transaction transaction,
  ) async {
    if (notifications == null || notifications.isEmpty) {
      return;
    }

    if (dayScheduleId == null) {
      throw StateError('Day schedule ID is missing.');
    }

    final rows = notifications
        .map(
          (notification) => Notification(
            dayScheduleId: dayScheduleId,
            title: notification.title,
            body: notification.body,
            scheduledDate: notification.scheduledDate,
            payload: notification.payload,
            updatedAt: DateTime.now(),
          ),
        )
        .toList();

    await Notification.db.insert(
      session,
      rows,
      transaction: transaction,
    );
  }
}
