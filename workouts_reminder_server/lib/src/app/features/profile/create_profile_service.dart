import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_profile_service.dart';

class CreateProfileService {
  const CreateProfileService();

  Future<Profile> callForUserId(Session session, UuidValue userId) async {
    final profile = Profile(
      userId: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      motivation: '',
      characterName: 'Champion',
      fitnessLevel: 'Beginner',
      notificationTone: 'Friendly',
    );

    await Profile.db.insertRow(session, profile);
    return await const GetProfileService().callForUserId(session, userId) ??
        profile;
  }
}
