import 'dart:convert';

import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/local_storage.dart';
import '../../data/models/user_profile_model.dart';
import '../../use_cases/profile_use_case.dart';

part 'profile_state.g.dart';

@Riverpod(keepAlive: true)
class ProfileState extends _$ProfileState {
  @override
  FutureOr<UserProfileModel> build() async {
    await persist(
      ref.watch(localStorageProvider.future),
      key: 'user_profile',
      encode: (state) => jsonEncode(state.toJson()),
      decode: (data) => UserProfileModel.fromJson(jsonDecode(data)),
    ).future;
    return state.value ?? UserProfileModel.empty();
  }

  void updateGoals(List<String> goals) {
    final current = state.requireValue;
    final updated = current.copyWith(goals: goals);
    state = AsyncValue.data(updated);
  }

  void updateMotivation(String motivation) {
    final current = state.requireValue;
    final updated = current.copyWith(motivation: motivation);
    state = AsyncValue.data(updated);
  }

  void updateCharacterName(String name) {
    final current = state.requireValue;
    final updated = current.copyWith(characterName: name);
    state = AsyncValue.data(updated);
  }
}
