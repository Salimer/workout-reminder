import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class ProgressEndpoint extends Endpoint {
  

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

  
}
