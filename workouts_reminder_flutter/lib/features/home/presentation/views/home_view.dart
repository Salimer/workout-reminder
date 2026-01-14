import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../progress/presentation/views/progress_view.dart';
import '../../../schedule/presentation/views/schedule_view.dart';
import '../../../settings/presentation/views/settings_view.dart';
import '../state/bottom_navigation.dart';
import 'main_view.dart';

// ***************
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final PageController _pageController;

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
    BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  static const _pages = [
    MainView(),
    ProgressView(),
    ScheduleView(),
    SettingsView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ref.read(bottomNavigationProvider).currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavListener(ref);

    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            return PageView(
              controller: _pageController,
              onPageChanged: (index) {
                ref
                    .read(bottomNavigationProvider.notifier)
                    .set(index: index, shouldAnimate: false);
              },
              children: _pages,
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          return BottomNavigationBar(
            currentIndex: ref.watch(
              bottomNavigationProvider.select((value) => value.currentIndex),
            ),
            items: _items,
            onTap: (index) {
              ref
                  .read(bottomNavigationProvider.notifier)
                  .set(index: index, shouldAnimate: true);
            },
          );
        },
      ),
    );
  }

  void _bottomNavListener(WidgetRef ref) {
    ref.listen(bottomNavigationProvider, (previous, next) {
      if (next.shouldAnimate && previous != next) {
        debugPrint("Animating to page: ${next.currentIndex}");
        _pageController.animateToPage(
          next.currentIndex,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
