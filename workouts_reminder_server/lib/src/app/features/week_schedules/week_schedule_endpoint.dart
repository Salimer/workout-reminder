import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'create_week_schedule_service.dart';

class WeekScheduleEndpoint extends Endpoint {
  final CreateWeekScheduleService _weekScheduleService =
      const CreateWeekScheduleService();

  @override
  bool get requireLogin => true;

  Future<void> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    await _weekScheduleService.call(session, weekSchedule);
  }

  Future<void> deleteWeekSchedule(Session session, int weekScheduleId) async {
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
