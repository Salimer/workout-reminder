import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../week_schedules/get_active_week_schedule_service.dart';

class UpdateDayScheduleStatusService {
  const UpdateDayScheduleStatusService();

  static const GetActiveWeekScheduleService _getActiveWeekScheduleService =
      GetActiveWeekScheduleService();

  Future<void> call(
    Session session, {
    required DayWorkoutStatusEnum status,
    required DateTime localDateTime,
  }) async {
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

      final weekday = WeekdayEnum.values[localDateTime.weekday - 1];
      final daySchedule = await DaySchedule.db.findFirstRow(
        session,
        where: (t) =>
            t.weekScheduleId.equals(activeWeek!.id) & t.day.equals(weekday),
        transaction: transaction,
      );

      if (daySchedule == null) {
        throw ServerpodException(
          message: 'DaySchedule not found for the provided date.',
          errorCode: 404,
        );
      }

      if (daySchedule.status == DayWorkoutStatusEnum.notScheduled) {
        throw ServerpodException(
          message: 'Today is not scheduled as a workout day.',
          errorCode: 422,
        );
      }

      final updatedDay = daySchedule.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );

      await DaySchedule.db.updateRow(
        session,
        updatedDay,
        columns: (t) => [t.status, t.updatedAt],
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
}
