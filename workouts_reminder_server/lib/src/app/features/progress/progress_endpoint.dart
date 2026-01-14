import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class ProgressEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('User is not authenticated.');
    }

    final userId = UuidValue.withValidation(authInfo.userIdentifier);

    await session.db.transaction((transaction) async {
      final existingProgress = await Progress.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
        transaction: transaction,
      );

      if (existingProgress == null) {
        await Progress.db.insertRow(
          session,
          Progress(
            userId: userId,
            weeks: [weekSchedule],
            updatedAt: DateTime.now(),
          ),
          transaction: transaction,
        );
        return;
      }

      final updatedProgress = existingProgress.copyWith(
        weeks: [...?existingProgress.weeks, weekSchedule],
        updatedAt: DateTime.now(),
      );

      await Progress.db.updateRow(
        session,
        updatedProgress,
        transaction: transaction,
      );
    });
  }
}
