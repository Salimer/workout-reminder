import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../use_cases/schedule_use_case.dart';
import '../../data/models/week_schedule_model.dart';
import '../../../notifications/data/models/notification_model.dart';

class WeekScheduleSummary extends StatelessWidget {
  final WeekScheduleModel schedule;

  const WeekScheduleSummary({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateRange =
        '${DateFormat.MMMd().format(schedule.createdAt)} · ${DateFormat.MMMd().format(schedule.deadline)}';

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'This week\'s schedule',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              schedule.note,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dateRange,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Clear current plan?'),
                    content: const Text(
                      'This will remove this week\'s schedule and notifications.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text('Cancel'),
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          ref.listen(clearWeekPlan, (_, state) {
                            if (state.isSuccess) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Schedule cleared.',
                                    ),
                                  ),
                                );
                              }
                            } else if (state.hasError) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error clearing schedule: ${(state as MutationError).error}',
                                    ),
                                  ),
                                );
                              }
                            }
                          });
                          return FilledButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              final mutation = clearWeekPlan;
                              mutation.run(ref, (tsx) async {
                                await Future.delayed(
                                  const Duration(
                                    seconds: 4,
                                  ),
                                ); // Allow UI to update before starting mutation
                                await tsx
                                    .get(scheduleUseCaseProvider)
                                    .clearWeekPlan();
                              });
                            },
                            child: const Text('Clear plan'),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              icon: Consumer(
                builder: (context, ref, _) {
                  final mutation = clearWeekPlan;
                  final state = ref.watch(mutation);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: state.isPending
                        ? const SizedBox.shrink()
                        : const Icon(Icons.delete_outline),
                  );
                },
              ),
              label: Consumer(
                builder: (context, ref, _) {
                  final mutation = clearWeekPlan;
                  final state = ref.watch(mutation);
                  if (state.isPending) {
                    return const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return const Text('Clear plan');
                },
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final day in schedule.days)
                  _DayCard(
                    dayLabel: day.day.day,
                    hasWorkout: day.hasWorkout,
                    notifications: day.notifications ?? const [],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final String dayLabel;
  final bool hasWorkout;
  final List<NotificationModel> notifications;

  const _DayCard({
    required this.dayLabel,
    required this.hasWorkout,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = hasWorkout
        ? theme.colorScheme.primary.withOpacity(0.1)
        : theme.colorScheme.surfaceContainerHighest.withOpacity(0.4);
    final borderColor = hasWorkout
        ? theme.colorScheme.primary.withOpacity(0.3)
        : theme.colorScheme.outlineVariant;

    return SizedBox(
      width: 200,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayLabel,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  hasWorkout ? Icons.fitness_center : Icons.weekend,
                  size: 18,
                  color: hasWorkout
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (!hasWorkout)
              Text(
                'Rest day',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final slot in _slotsWithFallback())
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${slot.label}: ${slot.time ?? 'Not set'}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  List<_Slot> _slotsWithFallback() {
    final labels = ['Morning', 'Afternoon', 'Evening'];
    final format = DateFormat.jm();

    return List.generate(labels.length, (index) {
      if (index < notifications.length) {
        final n = notifications[index];
        return _Slot(
          label: labels[index],
          time: format.format(n.scheduledDate),
        );
      }
      return _Slot(label: labels[index]);
    });
  }
}

class _Slot {
  final String label;
  final String? time;

  _Slot({required this.label, this.time});
}
