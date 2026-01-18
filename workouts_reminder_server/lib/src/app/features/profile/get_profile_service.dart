import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

class GetProfileService {
  const GetProfileService();

  Future<Profile?> call(Session session) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );
    return callForUserId(session, userId);
  }

  Future<Profile?> callForUserId(Session session, UuidValue userId) async {
    return Profile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
      include: Profile.include(
        goals: Goal.includeList(),
      ),
    );
  }
}
