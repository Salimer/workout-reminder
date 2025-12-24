import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../schedule/presentation/state/week_schedule.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, _) {
          final schedule = ref.watch(weekScheduleProvider);
          return schedule.when(
            data: (data) {
              //
              return Text('Week Schedule Note: ${data.note}');
            },
            error: (e, st) {
              return Text('Error: $e');
            },
            loading: () {
              return const CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
}

