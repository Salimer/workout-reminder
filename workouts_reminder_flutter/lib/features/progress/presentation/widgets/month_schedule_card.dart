import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import 'inline_legend.dart';
import 'month_status_pill.dart';
import 'week_mini_row.dart';

class MonthScheduleCard extends StatelessWidget {
  const MonthScheduleCard({
    required this.month,
    required this.weeks,
    required this.scheme,
    super.key,
  });

  final DateTime month;
  final List<WeekScheduleModel> weeks;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final orderedWeeks = weeks;
    final scheduledCount = weeks.length;
    final totalCount = weeks.length;

    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 10),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMMM').format(month),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$scheduledCount of $totalCount weeks scheduled',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
              MonthStatusPill(
                scheduledCount: scheduledCount,
                totalCount: totalCount,
                scheme: scheme,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const InlineLegend(),
          const SizedBox(height: 12),
          Column(
            children: orderedWeeks
                .map(
                  (week) => WeekMiniRow(
                    week: week,
                    scheme: scheme,
                    isFaded: false,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
