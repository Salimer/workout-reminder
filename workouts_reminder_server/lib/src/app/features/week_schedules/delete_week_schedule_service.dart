import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_active_week_schedule_service.dart';

class DeleteWeekScheduleService {
  const DeleteWeekScheduleService();

  static const GetActiveWeekScheduleService _getActiveWeekScheduleService =
      GetActiveWeekScheduleService();

  Future<void> call(Session session, DateTime localDateTime) async {
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

      final deletedRows = await WeekSchedule.db.deleteWhere(
        session,
        where: (t) =>
            t.id.equals(activeWeek!.id) & t.progressId.equals(progress.id!),
        transaction: transaction,
      );

      if (deletedRows.isEmpty) {
        throw ServerpodException(
          message: 'WeekSchedule not found or does not belong to the user.',
          errorCode: 404,
        );
      }
    });
  }
}
