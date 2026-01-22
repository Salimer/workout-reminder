import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'delete_user_service.dart';
import 'get_profile_service.dart';
import 'update_profile_service.dart';

class ProfileEndpoint extends Endpoint {
  final GetProfileService _getProfileService = const GetProfileService();

  final DeleteUserService _deleteUserService = const DeleteUserService();
  final UpdateProfileService _updateProfileService =
      const UpdateProfileService();

  @override
  bool get requireLogin => true;

  Future<Profile?> getProfile(Session session) async {
    return await _getProfileService.call(session);
  }

  Future<void> deleteUser(Session session) async {
    await _deleteUserService.call(session);
  }

  Future<Profile> updateProfile(
    Session session,
    Profile profile,
  ) async {
    return _updateProfileService.call(session, profile);
  }
}
