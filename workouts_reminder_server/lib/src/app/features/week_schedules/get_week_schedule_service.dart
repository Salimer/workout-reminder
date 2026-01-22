import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class GetWeekScheduleService {
  const GetWeekScheduleService();

  Future<WeekSchedule?> call(Session session, int weekScheduleId) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );

    final progress = await Progress.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    if (progress == null || progress.id == null) {
      throw ServerpodException(
        message: 'Progress not found for the user.',
        errorCode: 404,
      );
    }

    return WeekSchedule.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(weekScheduleId) & t.progressId.equals(progress.id!),
      include: WeekSchedule.include(
        days: DaySchedule.includeList(
          include: DaySchedule.include(
            notifications: Notification.includeList(),
          ),
        ),
      ),
    );
  }
}
