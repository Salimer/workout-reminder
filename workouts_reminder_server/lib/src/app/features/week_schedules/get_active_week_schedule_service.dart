import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class GetActiveWeekScheduleService {
  const GetActiveWeekScheduleService();

  Future<WeekSchedule?> call({
    required Session session,
    required int progressId,
    required DateTime localDateTime,
    Transaction? transaction,
  }) {
    return WeekSchedule.db.findFirstRow(
      session,
      where: (t) =>
          t.progressId.equals(progressId) &
          (t.createdAt <= localDateTime) &
          (t.deadline >= localDateTime),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      transaction: transaction,
    );
  }
}
