import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/animated_section.dart';
import '../../../../core/use_cases/app_use_case.dart';
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
    final scheme = theme.colorScheme;
    final dateRange =
        '${DateFormat.MMMd().format(schedule.createdAt)} · ${DateFormat.MMMd().format(schedule.deadline)}';

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAnimatedSection(
            index: 0,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This week\'s schedule',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        schedule.note,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateRange,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Active',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppAnimatedSection(
            index: 1,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Your week at a glance',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                              ref.listen(clearWeekPlanMutation, (_, state) {
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
                                  final mutation = clearWeekPlanMutation;
                                  mutation.run(ref, (tsx) async {
                                    await tsx
                                        .get(appUseCaseProvider)
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
                      final mutation = clearWeekPlanMutation;
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
                      final mutation = clearWeekPlanMutation;
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 12.0;
              final maxWidth = constraints.maxWidth;
              final columns = maxWidth >= 640
                  ? 3
                  : maxWidth >= 420
                  ? 2
                  : 1;
              final cardWidth =
                  (maxWidth - (spacing * (columns - 1))) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (final entry in schedule.days.asMap().entries)
                    SizedBox(
                      width: cardWidth,
                      child: AppAnimatedSection(
                        index: 2 + entry.key,
                        child: _DayCard(
                          dayLabel: entry.value.day.day,
                          hasWorkout: entry.value.hasWorkout,
                          notifications: entry.value.notifications ?? const [],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
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
    final scheme = theme.colorScheme;
    final color = hasWorkout
        ? scheme.primary.withValues(alpha: 0.12)
        : scheme.surfaceContainerHighest.withValues(alpha: 0.45);
    final borderColor = hasWorkout
        ? scheme.primary.withValues(alpha: 0.35)
        : scheme.onSurface.withValues(alpha: 0.1);
    final statusColor = hasWorkout ? scheme.primary : scheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  hasWorkout ? 'Workout' : 'Rest',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (!hasWorkout)
            Row(
              children: [
                Icon(
                  Icons.self_improvement_outlined,
                  size: 16,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Text(
                  'Recovery day',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final slot in _slotsWithFallback())
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: scheme.onSurface.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          slot.icon,
                          size: 14,
                          color: scheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${slot.label}: ${slot.time ?? 'Not set'}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurface.withValues(alpha: 0.75),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  List<_Slot> _slotsWithFallback() {
    final labels = ['Morning', 'Afternoon', 'Evening'];
    final icons = [
      Icons.wb_sunny_outlined,
      Icons.light_mode_outlined,
      Icons.nights_stay_outlined,
    ];
    final format = DateFormat.jm();

    return List.generate(labels.length, (index) {
      if (index < notifications.length) {
        final n = notifications[index];
        return _Slot(
          label: labels[index],
          time: format.format(n.scheduledDate),
          icon: icons[index],
        );
      }
      return _Slot(label: labels[index], icon: icons[index]);
    });
  }
}

class _Slot {
  final String label;
  final String? time;
  final IconData icon;

  _Slot({required this.label, this.time, required this.icon});
}
