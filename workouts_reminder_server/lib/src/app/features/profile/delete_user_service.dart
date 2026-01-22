import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../../generated/protocol.dart';

class DeleteUserService {
  const DeleteUserService();

  Future<void> call(Session session) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );

    await session.db.transaction((transaction) async {
      await Progress.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );

      await Profile.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );

      await const AuthUsers().delete(
        session,
        authUserId: userId,
        transaction: transaction,
      );
    });
  }
}
