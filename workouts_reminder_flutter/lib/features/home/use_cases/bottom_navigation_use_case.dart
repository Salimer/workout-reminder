import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../presentation/state/bottom_navigation.dart';

part 'bottom_navigation_use_case.g.dart';

@Riverpod(keepAlive: true)
BottomNavigationUseCase bottomNavigationUseCase(Ref ref) =>
    BottomNavigationUseCase(ref);

class BottomNavigationUseCase {
  final Ref ref;
  BottomNavigationUseCase(this.ref);

  void goToProgressView() {
    ref
        .read(bottomNavigationProvider.notifier)
        .set(index: 1, shouldAnimate: true);
  }

  void goToScheduleView() {
    ref
        .read(bottomNavigationProvider.notifier)
        .set(index: 2, shouldAnimate: true);
  }

  void goToMainView() {
    ref
        .read(bottomNavigationProvider.notifier)
        .set(index: 0, shouldAnimate: true);
  }
}
