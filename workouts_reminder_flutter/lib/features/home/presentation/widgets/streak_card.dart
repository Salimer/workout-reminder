import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/app_card.dart';
import '../state/home_view_state.dart';
import '../../../schedule/data/models/day_schedule_model.dart';

class StreakCard extends ConsumerWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewStateProvider);
    final streak = state.streakDays;
    final weekDays = state.currentWeekDays;

    final ColorScheme scheme = Theme.of(context).colorScheme;

    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedFire,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Streak',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$streak days strong',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Week Glance Dots
          if (weekDays.isNotEmpty)
            _WeekGlanceRow(
              weekDays: weekDays,
              scheme: scheme,
              weekStartDate: state.weekStartDate,
            )
          else
            Text(
              "Plan your week to track progress",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
        ],
      ),
    );
  }
}

class _WeekGlanceRow extends StatelessWidget {
  const _WeekGlanceRow({
    required this.weekDays,
    required this.scheme,
    this.weekStartDate,
  });

  final List<DayScheduleModel> weekDays;
  final ColorScheme scheme;
  final DateTime? weekStartDate;

  @override
  Widget build(BuildContext context) {
    // Reorder days starting from the week's creation day
    final days = _reorderDaysFromWeekStart(weekDays);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) => _DayDot(day: day, scheme: scheme)).toList(),
    );
  }

  /// Reorder days to start from the week's creation date
  /// For example, if week started on Sunday, order will be: Sun, Mon, Tue, Wed, Thu, Fri, Sat
  List<DayScheduleModel> _reorderDaysFromWeekStart(
    List<DayScheduleModel> days,
  ) {
    if (days.isEmpty) return days;

    // First, sort by day index to ensure consistent ordering (Mon=0, ..., Sun=6)
    final sortedDays = List<DayScheduleModel>.from(days)
      ..sort((a, b) => a.day.index.compareTo(b.day.index));

    // If we have the week start date, use it to determine the start day
    if (weekStartDate != null) {
      // Get the weekday when the week was created (1 = Mon, ..., 7 = Sun)
      final startWeekday = weekStartDate!.weekday;
      // Convert to 0-based index matching WeekdayEnum (0 = Mon, ..., 6 = Sun)
      final startIndex = startWeekday - 1;

      // Reorder: days from startIndex to end, then days from 0 to startIndex
      final reordered = [
        ...sortedDays.sublist(startIndex),
        ...sortedDays.sublist(0, startIndex),
      ];

      return reordered;
    }

    // Fallback: if no start date, return days as-is (Mon-Sun)
    return sortedDays;
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day, required this.scheme});

  final DayScheduleModel day;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final status = day.status;
    final dayLabel = day.day.name.substring(0, 1).toUpperCase();
    final isToday =
        day.day == WeekdayEnum.fromDateTimeWeekday(DateTime.now().weekday);

    // Determine styles based on status
    Color color;
    BoxBorder? border;
    Widget? icon;

    switch (status) {
      case DayWorkoutStatusEnum.performed:
        color = Colors.green;
        icon = const HugeIcon(
          icon: HugeIcons.strokeRoundedTick02,
          size: 12,
          color: Colors.white,
        );
        break;
      case DayWorkoutStatusEnum.skipped:
        color = Colors.orange.withValues(alpha: 0.2);
        icon = const HugeIcon(
          icon: HugeIcons.strokeRoundedCancel01,
          size: 12,
          color: Colors.orange,
        );
        break;
      case DayWorkoutStatusEnum.pending:
        // Check if today or future?
        // Simple logic: Pending/Scheduled is Blue Ring
        color = Colors.transparent;
        border = Border.all(color: scheme.primary, width: 2);
        break;
      case DayWorkoutStatusEnum.notScheduled:
        color = scheme.surfaceContainerHighest.withValues(alpha: 0.5);
        break;
    }

    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border,
          ),
          child: Center(child: icon),
        ),
        const SizedBox(height: 6),
        Text(
          dayLabel,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isToday
                ? scheme.primary
                : scheme.onSurface.withValues(alpha: 0.5),
            fontSize: 10,
            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        if (isToday) ...[
          const SizedBox(height: 4),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ],
    );
  }
}
