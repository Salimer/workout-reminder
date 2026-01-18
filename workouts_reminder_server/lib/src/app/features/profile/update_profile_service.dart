import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_profile_service.dart';

class UpdateProfileService {
  const UpdateProfileService();

  Future<Profile> call(Session session, Profile profile) async {
    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );

    return session.db.transaction<Profile>((transaction) async {
      final existingProfile = await const GetProfileService().callForUserId(
        session,
        userId,
        transaction: transaction,
      );

      if (existingProfile == null) {
        throw ServerpodException(
          message: 'Profile does not exist for the user.',
          errorCode: 404,
        );
      }

      final updatedProfile = existingProfile.copyWith(
        motivation: profile.motivation,
        characterName: profile.characterName,
        fitnessLevel: profile.fitnessLevel,
        notificationTone: profile.notificationTone,
        updatedAt: DateTime.now(),
      );

      final savedProfile = await Profile.db.updateRow(
        session,
        updatedProfile,
        columns: (t) => [
          t.motivation,
          t.characterName,
          t.fitnessLevel,
          t.notificationTone,
          t.updatedAt,
        ],
        transaction: transaction,
      );

      await Goal.db.deleteWhere(
        session,
        where: (t) => t.profileId.equals(savedProfile.id!),
        transaction: transaction,
      );

      final goals = profile.goals ?? [];
      if (goals.isNotEmpty) {
        final goalRows = goals
            .map(
              (goal) => Goal(
                profileId: savedProfile.id!,
                text: goal.text,
                updatedAt: DateTime.now(),
              ),
            )
            .toList();
        await Goal.db.insert(
          session,
          goalRows,
          transaction: transaction,
        );
      }

      final refreshedProfile = await const GetProfileService().callForUserId(
        session,
        userId,
        transaction: transaction,
      );
      return refreshedProfile ?? savedProfile;
    });
  }
}
