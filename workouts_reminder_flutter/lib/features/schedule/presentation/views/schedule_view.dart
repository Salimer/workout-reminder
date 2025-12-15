import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/core/providers/local_time_date.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, _) {
          final time = ref.watch(localTimeDateProvider);
          return Text('Local time: $time');
        },
      ),
    );
  }
}
