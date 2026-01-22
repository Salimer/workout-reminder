import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
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
        Consumer(
          builder: (context, ref, _) {
            ref.listen(changeDayWorkoutStatusMutation, (_, state) {
              if (state.hasError && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error updating today\'s status: ${(state as MutationError).error}',
                    ),
                  ),
                );
              }
            });
            final state = ref.watch(changeDayWorkoutStatusMutation);
            return StartWorkoutSlider(
              isLoading: state.isPending,
              onTriggered: (ref) async {
                final mutation = changeDayWorkoutStatusMutation;
                await mutation.run(
                  ref,
                  (tsx) async {
                    await ref.read(appUseCaseProvider).performTodayWorkout();
                  },
                );
              },
            );
          },
        ),
        if (showSkip) ...[
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(changeDayWorkoutStatusMutation);
                return TextButton.icon(
                  onPressed: state.isPending
                      ? null
                      : () {
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
                                Consumer(
                                  builder: (context, ref, _) {
                                    final state = ref.watch(
                                      changeDayWorkoutStatusMutation,
                                    );
                                    return FilledButton(
                                      onPressed: state.isPending
                                          ? null
                                          : () async {
                                              ref.read(routesProvider).pop();
                                              final mutation =
                                                  changeDayWorkoutStatusMutation;
                                              await mutation.run(
                                                ref,
                                                (tsx) async {
                                                  await ref
                                                      .read(appUseCaseProvider)
                                                      .skipTodayWorkout();
                                                },
                                              );
                                            },
                                      child: state.isPending
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text('Skip today'),
                                    );
                                  },
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
