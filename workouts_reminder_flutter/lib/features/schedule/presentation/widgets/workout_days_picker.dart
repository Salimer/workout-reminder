import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../use_cases/schedule_use_case.dart';

class WorkoutDaysPicker extends StatefulWidget {
  final Set<WeekdayEnum> initialSelectedDays;

  const WorkoutDaysPicker({
    super.key,
    this.initialSelectedDays = const {},
  });

  @override
  State<WorkoutDaysPicker> createState() => _WorkoutDaysPickerState();
}

class _WorkoutDaysPickerState extends State<WorkoutDaysPicker> {
  late final Set<WeekdayEnum> _selectedDays = {...widget.initialSelectedDays};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick your workout days',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We’ll schedule 3 reminders per selected day: morning, afternoon, and evening.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final day in WeekdayEnum.values)
                        FilterChip(
                          label: Text(day.day),
                          selected: _selectedDays.contains(day),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(day);
                              } else {
                                _selectedDays.remove(day);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final mutation = scheduleWeekPlanMutation;
                        final state = ref.watch(mutation);
                        ref.listen(mutation, (_, next) {
                          if (next.hasError) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error scheduling workouts: ${(next as MutationError).error}',
                                  ),
                                ),
                              );
                            }
                          }
                        });
                        return FilledButton(
                          onPressed:
                              _selectedDays.isNotEmpty && !state.isPending
                              ? () async {
                                  await scheduleWeekPlanMutation
                                      .run(ref, (
                                        tsx,
                                      ) async {
                                        await Future.delayed(
                                          const Duration(seconds: 3),
                                        );
                                        await tsx
                                            .get(
                                              scheduleUseCaseProvider,
                                            )
                                            .createWeekSchedule(_selectedDays);
                                      })
                                      .catchError((_) {});
                                }
                              : null,
                          child: state.isPending
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Create schedule'),
                        );
                      },
                    ),
                  ),
                  if (_selectedDays.isEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Select at least one day to continue.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
