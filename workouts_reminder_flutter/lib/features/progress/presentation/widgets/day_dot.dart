import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../schedule/data/models/day_schedule_model.dart';
import '../../data/models/day_style_model.dart';

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
    final style = DayStyleModel.fromStatus(day.status, scheme);
    final status = day.status;
    final bool isCompleted = status == DayWorkoutStatusEnum.performed;
    final bool isSkipped = status == DayWorkoutStatusEnum.skipped;
    final bool showAccentFill = isCompleted || isSkipped;
    final ringColor = isToday ? scheme.primary : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day.day.day.substring(0, 1).toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 9,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w600,
              color: isToday
                  ? scheme.primary
                  : scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: showAccentFill ? style.accent : style.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: isToday
                    ? ringColor
                    : showAccentFill
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
                : isSkipped
                ? const Icon(
                    Icons.close,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
          if (isToday) ...[
            const SizedBox(height: 3),
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
      ),
    );
  }
}
