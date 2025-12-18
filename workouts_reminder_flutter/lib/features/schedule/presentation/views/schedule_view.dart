import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../progress/presentation/widgets/workout_days_picker.dart';
import '../../controllers/notifications_controller.dart';
import '../../data/models/week_schedule_model.dart';
import '../state/week_schedule.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, _) {
          final week = ref.watch(weekScheduleProvider);
          final mutation = notificationMutation;
          return week.when(
            data: (data) {
              if (data.isSet == false || data.isCompleted) {
                return WorkoutDaysPicker(
                  onSave: (selectedDays) async {
                    final schedule = WeekScheduleModel.forWorkoutDays(
                      workoutDays: selectedDays,
                    );
                    mutation.run(ref, (tsx) async {
                      final controller = tsx.get(
                        notificationsControllerProvider,
                      );
                      await controller.scheduleWeekNotifications(schedule);

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Workout schedule created.'),
                        ),
                      );
                    });
                    // ref.read(weekScheduleProvider.notifier).set(schedule);
                  },
                );
              }

              return const _ProgressPlaceholder();
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
          );
          // return Text('Welcome to the Progress View!');
        },
      ),
    );
  }
}

class _ProgressPlaceholder extends StatelessWidget {
  const _ProgressPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text('Progress view placeholder (schedule already set).'),
    );
  }
}
