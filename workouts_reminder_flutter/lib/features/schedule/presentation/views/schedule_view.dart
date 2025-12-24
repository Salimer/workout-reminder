import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/notifications_controller.dart';
import '../../data/models/week_schedule_model.dart';
import '../state/week_schedule.dart';
import '../widgets/week_schedule_summary.dart';
import '../widgets/workout_days_picker.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, _) {
          final week = ref.watch(weekScheduleProvider);
          final mutation = scheduleWeekNotifications;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: week.when(
              data: (data) {
                if (data.isSet == false || data.isCompleted) {
                  return WorkoutDaysPicker(
                    onSave: (selectedDays) async {
                      await Future.delayed(
                        const Duration(
                          seconds: 3,
                        ),
                      ); // Allow UI to update before starting mutation
                      final schedule = WeekScheduleModel.forWorkoutDays(
                        workoutDays: selectedDays,
                      );
                      await mutation.run(ref, (tsx) async {
                        await tsx
                            .get(
                              notificationsControllerProvider,
                            )
                            .scheduleWeekNotifications(schedule);

                        tsx.get(weekScheduleProvider.notifier).set(schedule);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Workout schedule created.'),
                          ),
                        );
                      });
                    },
                  );
                }

                return WeekScheduleSummary(schedule: data);
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
          );
          // return Text('Welcome to the Progress View!');
        },
      ),
    );
  }
}
