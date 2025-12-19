import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return ListView(
      children: [
        ConstrainedBox(
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
        ),
      ],
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
