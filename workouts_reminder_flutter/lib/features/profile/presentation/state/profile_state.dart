import 'dart:convert';

import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/client.dart';
import '../../../../core/providers/local_storage.dart';
import '../../data/models/goal_model.dart';
import '../../data/models/profile_model.dart';

part 'profile_state.g.dart';

@Riverpod(keepAlive: false)
class ProfileState extends _$ProfileState {
  @override
  FutureOr<ProfileModel> build() async {
    final storageFuture = ref.watch(localStorageProvider.future);
    persist(
      storageFuture,
      key: 'user_profile',
      options: const StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: '1.0.0',
      ),
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => ProfileModel.fromJson(jsonDecode(data)),
    );
    ref.onDispose(() {
      storageFuture.then((storage) async {
        await storage.delete('user_profile');
      });
    });

    ProfileModel profile;

    try {
      profile = await _fetchProfile();
    } catch (_) {
      profile = state.value ?? ProfileModel.empty();
    }

    return profile;
  }

  Future<ProfileModel> _fetchProfile() async {
    final client = ref.read(clientProvider);
    final profileData = await client.profile.getProfile();

    if (profileData == null) {
      throw Exception('No profile data found from server');
    }

    return ProfileModel.fromServerProfile(profileData);
  }

  void set(ProfileModel data) {
    state = AsyncValue.data(data);
  }

  ProfileModel currentState() {
    return state.requireValue;
  }

  void updateGoals(List<GoalModel> goals) {
    final updated = currentState().copyWith(goals: goals);
    set(updated);
  }

  void updateMotivation(String motivation) {
    final updated = currentState().copyWith(motivation: motivation);
    set(updated);
  }

  void updateCharacterName(String name) {
    final updated = currentState().copyWith(characterName: name);
    set(updated);
  }

  void updateFitnessLevel(String level) {
    final updated = currentState().copyWith(fitnessLevel: level);
    set(updated);
  }

  void updateNotificationTone(String tone) {
    final updated = currentState().copyWith(notificationTone: tone);
    set(updated);
  }
}
