import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'first_relaunch.g.dart';

@Riverpod(keepAlive: true)
class FirstRelaunch extends _$FirstRelaunch {
  @override
  bool build() {
    // Simulate some initialization delay if needed.
    return true;
  }

  void setFalse() {
    state = false;
  }
}