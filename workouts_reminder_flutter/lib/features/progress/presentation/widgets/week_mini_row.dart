import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/helper_methods.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import 'day_dot.dart';

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
    final todayEnum = WeekdayEnum.fromDateTimeWeekday(now.weekday);
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
                    week.note ?? 'Weekly Plan',
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
              children: reorderDaysFromWeekStart(week.days, week.createdAt)
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
