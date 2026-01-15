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
      final progress = await _getOrCreateProgress(
        session,
        userId,
        transaction,
      );

      final insertedWeek = await _insertWeekSchedule(
        session,
        weekSchedule,
        transaction,
      );

      await Progress.db.attachRow.weeks(
        session,
        progress,
        insertedWeek,
        transaction: transaction,
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
      where: (t) => t.userId.equals(userId),
      transaction: transaction,
    );
  }

  Future<Progress> _getOrCreateProgress(
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
      final progress = Progress(
        userId: userId,
        updatedAt: DateTime.now(),
      );
      return Progress.db.insertRow(
        session,
        progress,
        transaction: transaction,
      );
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
    Transaction transaction,
  ) {
    final row = WeekSchedule(
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

    for (final day in days) {
      final insertedDay = await _insertDaySchedule(
        session,
        day,
        transaction,
      );

      await WeekSchedule.db.attachRow.days(
        session,
        weekSchedule,
        insertedDay,
        transaction: transaction,
      );

      await _insertNotifications(
        session,
        insertedDay,
        day.notifications,
        transaction,
      );
    }
  }

  Future<DaySchedule> _insertDaySchedule(
    Session session,
    DaySchedule daySchedule,
    Transaction transaction,
  ) {
    final row = DaySchedule(
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
    DaySchedule daySchedule,
    List<Notification>? notifications,
    Transaction transaction,
  ) async {
    if (notifications == null || notifications.isEmpty) {
      return;
    }

    final rows = notifications
        .map(
          (notification) => Notification(
            title: notification.title,
            body: notification.body,
            scheduledDate: notification.scheduledDate,
            payload: notification.payload,
            updatedAt: DateTime.now(),
          ),
        )
        .toList();

    final insertedNotifications = await Notification.db.insert(
      session,
      rows,
      transaction: transaction,
    );

    await DaySchedule.db.attach.notifications(
      session,
      daySchedule,
      insertedNotifications,
      transaction: transaction,
    );
  }
}
