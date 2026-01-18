import 'package:serverpod/serverpod.dart';
import '../../../generated/protocol.dart';
import 'create_profile_service.dart';
import 'delete_user_service.dart';
import 'get_profile_service.dart';

class ProfileEndpoint extends Endpoint {
  final GetProfileService _getProfileService = const GetProfileService();
  final CreateProfileService _createProfileService =
      const CreateProfileService();
  final DeleteUserService _deleteUserService = const DeleteUserService();

  @override
  bool get requireLogin => true;

  Future<Profile?> getOrCreateProfile(Session session) async {
    final profile = await _getProfileService.call(session);
    if (profile != null) {
      return profile;
    }

    final userId = UuidValue.withValidation(
      session.authenticated!.userIdentifier,
    );
    return _createProfileService.callForUserId(session, userId);
  }

  Future<void> deleteUser(Session session) async {
    await _deleteUserService.call(session);
  }
}
