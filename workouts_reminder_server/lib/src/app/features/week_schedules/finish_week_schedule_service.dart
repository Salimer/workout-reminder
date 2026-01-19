import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_active_week_schedule_service.dart';

class FinishWeekScheduleService {
  const FinishWeekScheduleService();

  static const GetActiveWeekScheduleService _getActiveWeekScheduleService =
      GetActiveWeekScheduleService();

  Future<void> call(
    Session session, {
    required String note,
    required DateTime localDateTime,
  }) async {
    final trimmedNote = note.trim();
    if (trimmedNote.isEmpty) {
      throw ServerpodException(
        message: 'Please add a short reflection before finishing the week.',
        errorCode: 422,
      );
    }

    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );

    await session.db.transaction((transaction) async {
      final progress = await Progress.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );

      if (progress == null || progress.id == null) {
        throw ServerpodException(
          message: 'Progress not found for the user.',
          errorCode: 404,
        );
      }

      final activeWeek = await _getActiveWeekScheduleService.call(
        session: session,
        progressId: progress.id!,
        localDateTime: localDateTime,
        transaction: transaction,
      );

      if (activeWeek?.id == null) {
        throw ServerpodException(
          message: 'WeekSchedule not found for the provided date.',
          errorCode: 404,
        );
      }

      if (activeWeek!.note != null) {
        throw ServerpodException(
          message: 'Week is already finished.',
          errorCode: 422,
        );
      }

      if (!_isSameDate(localDateTime, activeWeek.deadline)) {
        throw ServerpodException(
          message: 'Week can only be finished on its last day.',
          errorCode: 422,
        );
      }

      final weekday = WeekdayEnum.values[localDateTime.weekday - 1];
      final daySchedule = await DaySchedule.db.findFirstRow(
        session,
        where: (t) =>
            t.weekScheduleId.equals(activeWeek.id) & t.day.equals(weekday),
        transaction: transaction,
      );

      if (daySchedule == null) {
        throw ServerpodException(
          message: 'DaySchedule not found for the provided date.',
          errorCode: 404,
        );
      }

      if (daySchedule.status == DayWorkoutStatusEnum.pending) {
        throw ServerpodException(
          message: 'Finish today\'s workout before ending the week.',
          errorCode: 422,
        );
      }

      await WeekSchedule.db.updateRow(
        session,
        activeWeek.copyWith(
          note: trimmedNote,
          updatedAt: DateTime.now(),
        ),
        columns: (t) => [t.note, t.updatedAt],
        transaction: transaction,
      );

      await Progress.db.updateRow(
        session,
        progress.copyWith(updatedAt: DateTime.now()),
        columns: (t) => [t.updatedAt],
        transaction: transaction,
      );
    });
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}
