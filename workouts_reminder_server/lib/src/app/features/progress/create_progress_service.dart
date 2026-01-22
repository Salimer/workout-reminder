import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class CreateProgressService {
  const CreateProgressService();

  Future<Progress> callForUserId(
    Session session,
    UuidValue userId, {
    Transaction? transaction,
  }) async {
    final progress = Progress(
      authUserId: userId,
      updatedAt: DateTime.now(),
    );

    return Progress.db.insertRow(
      session,
      progress,
      transaction: transaction,
    );
  }
}
