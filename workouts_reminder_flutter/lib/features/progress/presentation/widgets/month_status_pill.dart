import 'package:flutter/material.dart';

class MonthStatusPill extends StatelessWidget {
  const MonthStatusPill({
    required this.scheduledCount,
    required this.totalCount,
    required this.scheme,
    super.key,
  });

  final int scheduledCount;
  final int totalCount;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isFullyScheduled = scheduledCount == totalCount && totalCount > 0;
    final color = isFullyScheduled ? Colors.green : scheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isFullyScheduled ? 'Locked in' : 'In progress',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
            ),
      ),
    );
  }
}
