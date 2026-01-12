import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';
import '../../data/models/progress_model.dart';

class ProgressHighlights extends StatelessWidget {
  const ProgressHighlights({required this.progress, super.key});

  final ProgressModel progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: StatTile(
            title: 'Scheduled',
            value: '${progress.scheduledDays}',
            caption: 'Sessions',
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatTile(
            title: 'Completed',
            value: '${progress.completedDays}',
            caption: 'Sessions',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatTile(
            title: 'Weeks',
            value: '${progress.plannedWeeks}',
            caption: 'Planned',
            color: scheme.secondary,
          ),
        ),
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({
    required this.title,
    required this.value,
    required this.caption,
    required this.color,
    super.key,
  });

  final String title;
  final String value;
  final String caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: scheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.75),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
