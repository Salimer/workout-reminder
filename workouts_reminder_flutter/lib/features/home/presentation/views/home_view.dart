import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../progress/presentation/views/progress_view.dart';
import '../../../schedule/presentation/views/schedule_view.dart';
import '../../../settings/presentation/views/settings_view.dart';
import 'main_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final PageController _pageController;
  late int _currentIndex;

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
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            return PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: _pages,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) {
          if (index == _currentIndex) return;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
