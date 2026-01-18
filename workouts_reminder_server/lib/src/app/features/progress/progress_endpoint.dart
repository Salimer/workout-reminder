import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'create_week_schedule_service.dart';

class ProgressEndpoint extends Endpoint {
  final CreateWeekScheduleService _progressService =
      const CreateWeekScheduleService();

  @override
  bool get requireLogin => true;

  Future<Progress?> getProgress(Session session) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );
    final progress = await Progress.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      include: Progress.include(
        weeks: WeekSchedule.includeList(
          include: WeekSchedule.include(
            days: DaySchedule.includeList(
              include: DaySchedule.include(
                notifications: Notification.includeList(),
              ),
            ),
          ),
        ),
      ),
    );

    return progress;
  }

  Future<void> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    await _progressService.call(session, weekSchedule);
  }
}
