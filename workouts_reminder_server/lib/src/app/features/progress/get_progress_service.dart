import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class GetProgressService {
  const GetProgressService();

  Future<Progress?> call(Session session) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );
    return Progress.db.findFirstRow(
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
  }
}
