import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifications/data/models/notification_model.dart';
import '../../../progress/presentation/views/progress_view.dart';
import '../../../schedule/presentation/views/schedule_view.dart';
import '../../../settings/presentation/views/settings_view.dart';
import '../../controllers/notifications_controller.dart';
import 'main_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("HomeView rebuilt with currentIndex: $_currentIndex");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_items[_currentIndex].label ?? 'Home'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final mutation = notificationMutation;
          final state = ref.watch(mutation);

          switch (state) {
            case MutationIdle():
              return ElevatedButton(
                onPressed: () async {
                  mutation.run(ref, (tsx) async {
                    final notifier = tsx.get(notificationsControllerProvider);
                    await notifier.scheduleNotification(
                      NotificationModel.init(),
                    );
                  });
                },
                child: const Text('Schedule Notification'),
              );
            case MutationPending():
              return const Center(child: CircularProgressIndicator());
            case MutationError():
              return Center(child: Text('Error: ${state.error}'));
            case MutationSuccess():
              return PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: _pages,
              );
          }
        },
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
