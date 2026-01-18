import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_profile_service.dart';

class CreateProfileService {
  const CreateProfileService();

  Future<Profile> callForUserId(
    Session session,
    UuidValue userId, {
    Transaction? transaction,
  }) async {
    final profile = Profile(
      authUserId: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      motivation: '',
      characterName: 'Champion',
      fitnessLevel: 'Beginner',
      notificationTone: 'Friendly',
    );

    await Profile.db.insertRow(
      session,
      profile,
      transaction: transaction,
    );
    return await const GetProfileService().callForUserId(
          session,
          userId,
          transaction: transaction,
        ) ??
        profile;
  }
}
