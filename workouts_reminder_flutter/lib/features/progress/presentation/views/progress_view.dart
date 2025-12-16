import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/features/schedule/presentation/state/week_schedule.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, _) {
          final week = ref.watch(weekScheduleProvider);
          return week.when(
            data: (data) =>
                Text('Week Schedule Loaded with ${data.note} workouts'),
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
          );
          // return Text('Welcome to the Progress View!');
        },
      ),
    );
  }
}
