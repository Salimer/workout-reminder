import 'dart:convert';

import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/local_storage.dart';
import '../../data/models/profile_model.dart';

part 'profile_state.g.dart';

@Riverpod(keepAlive: false)
class ProfileState extends _$ProfileState {
  @override
  FutureOr<ProfileModel> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'user_profile',
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => ProfileModel.fromJson(jsonDecode(data)),
    ).future;
    return state.value ?? ProfileModel.empty();
  }

  void set(ProfileModel data) {
    state = AsyncValue.data(data);
  }

  ProfileModel currentState() {
    return state.requireValue;
  }

  void updateGoals(List<String> goals) {
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
