import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/use_cases/app_use_case.dart';
import 'start_workout_slider.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    super.key,
    required this.showSkip,
  });

  final bool showSkip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StartWorkoutSlider(
          onTriggered: (ref) async {
            final mutation = changeDayWorkoutStatusMutation;
            mutation
                .run(ref, (tsx) async {
                  await ref.read(appUseCaseProvider).performTodayWorkout();
                })
                .catchError((_) {});
          },
        ),
        if (showSkip) ...[
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Consumer(
              builder: (context, ref, _) {
                return TextButton.icon(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Hey chill buddy!!!'),
                        content: const Text('Why are we skipping today?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Back'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              ref.read(routesProvider).pop();
                              final mutation = changeDayWorkoutStatusMutation;
                              mutation
                                  .run(ref, (tsx) async {
                                    await ref
                                        .read(appUseCaseProvider)
                                        .skipTodayWorkout();
                                  })
                                  .catchError((_) {});
                            },
                            child: const Text('Skip today'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.not_interested),
                  label: const Text('Skip today'),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
