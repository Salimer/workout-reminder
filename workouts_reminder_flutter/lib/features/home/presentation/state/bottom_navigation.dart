import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation.g.dart';

// 0 - Home
// 1 - Schedule
// 2 - Progress
// 3 - Settings

@Riverpod(keepAlive: true)
class BottomNavigation extends _$BottomNavigation {
  @override
  BottomNavigationState build() {
    return BottomNavigationState(
      currentIndex: 0,
      shouldAnimate: true,
    );
  }

  void set({required int index, required bool shouldAnimate}) {
    state = BottomNavigationState(
      currentIndex: index,
      shouldAnimate: shouldAnimate,
    );
  }
}

class BottomNavigationState {
  final int currentIndex;
  final bool shouldAnimate;

  BottomNavigationState({
    required this.currentIndex,
    required this.shouldAnimate,
  });
}
