import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class DeleteWeekScheduleService {
  const DeleteWeekScheduleService();

  Future<void> call(Session session, int weekScheduleId) async {
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

      final deletedRows = await WeekSchedule.db.deleteWhere(
        session,
        where: (t) =>
            t.id.equals(weekScheduleId) & t.progressId.equals(progress.id!),
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
