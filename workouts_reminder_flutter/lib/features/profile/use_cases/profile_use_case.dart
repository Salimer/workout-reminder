import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../presentation/state/profile_state.dart';

part 'profile_use_case.g.dart';

@Riverpod(keepAlive: true)
class ProfileUseCase extends _$ProfileUseCase {
  @override
  void build() {}

  void updateGoals(List<String> goals) {
    ref.read(profileStateProvider.notifier).updateGoals(goals);
  }

  void updateMotivation(String motivation) {
    ref.read(profileStateProvider.notifier).updateMotivation(motivation);
  }

  void updateCharacterName(String name) {
    ref.read(profileStateProvider.notifier).updateCharacterName(name);
  }
}
