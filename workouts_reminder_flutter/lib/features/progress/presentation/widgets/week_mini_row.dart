import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../schedule/data/models/day_schedule_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';

class WeekMiniRow extends StatelessWidget {
  const WeekMiniRow({
    required this.week,
    required this.scheme,
    required this.isFaded,
    super.key,
  });

  final WeekScheduleModel week;
  final ColorScheme scheme;
  final bool isFaded;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isActiveWeek =
        !now.isBefore(week.createdAt) && !now.isAfter(week.deadline);
    final todayEnum = WeekdayEnum.values[now.weekday - 1];
    final rangeText = _formatRange(week.createdAt, week.deadline);
    final opacity = isFaded ? 0.45 : 1.0;
    final scheduledDays = week.days
        .where((day) => day.status != DayWorkoutStatusEnum.notScheduled)
        .length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    week.note,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rangeText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$scheduledDays/7',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: week.days
                  .map(
                    (day) => DayDot(
                      day: day,
                      scheme: scheme,
                      isToday: isActiveWeek && day.day == todayEnum,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class DayDot extends StatelessWidget {
  const DayDot({
    required this.day,
    required this.scheme,
    required this.isToday,
    super.key,
  });

  final DayScheduleModel day;
  final ColorScheme scheme;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final style = DayStyle.fromStatus(day.status, scheme);
    final bool isCompleted = day.status == DayWorkoutStatusEnum.performed;
    final ringColor = isToday ? const Color(0xFF7C3AED) : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day.day.day.substring(0, 1).toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isCompleted ? style.accent : style.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: isToday
                    ? ringColor
                    : isCompleted
                        ? style.accent
                        : style.border,
                width: isToday ? 2 : 1,
              ),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class DayStyle {
  final Color background;
  final Color border;
  final Color text;
  final Color accent;

  const DayStyle({
    required this.background,
    required this.border,
    required this.text,
    required this.accent,
  });

  factory DayStyle.fromStatus(
    DayWorkoutStatusEnum status,
    ColorScheme scheme,
  ) {
    switch (status) {
      case DayWorkoutStatusEnum.performed:
        return DayStyle(
          background: const Color(0xFF12B76A).withValues(alpha: 0.2),
          border: const Color(0xFF12B76A).withValues(alpha: 0.45),
          text: const Color(0xFF0B7A4B),
          accent: const Color(0xFF12B76A),
        );
      case DayWorkoutStatusEnum.skipped:
        return DayStyle(
          background: Colors.red.withValues(alpha: 0.12),
          border: Colors.red.withValues(alpha: 0.25),
          text: Colors.red.shade700,
          accent: Colors.red,
        );
      case DayWorkoutStatusEnum.pending:
        return DayStyle(
          background: const Color(0xFF3B82F6).withValues(alpha: 0.16),
          border: const Color(0xFF3B82F6).withValues(alpha: 0.45),
          text: const Color(0xFF1D4ED8),
          accent: const Color(0xFF3B82F6),
        );
      case DayWorkoutStatusEnum.notScheduled:
        return DayStyle(
          background: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: scheme.onSurface.withValues(alpha: 0.08),
          text: scheme.onSurface.withValues(alpha: 0.6),
          accent: scheme.onSurface.withValues(alpha: 0.35),
        );
    }
  }
}

String _formatRange(DateTime start, DateTime end) {
  return '${_formatDate(start)} - ${_formatDate(end)}';
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final month = months[date.month - 1];
  return '$month ${date.day}';
}
