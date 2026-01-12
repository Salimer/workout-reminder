import 'package:flutter/material.dart';

class InlineLegend extends StatelessWidget {
  const InlineLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        LegendItem(
          label: 'Scheduled',
          color: const Color(0xFF3B82F6),
        ),
        const LegendItem(
          label: 'Completed',
          color: Color(0xFF12B76A),
        ),
        const LegendItem(
          label: 'Skipped',
          color: Colors.red,
        ),
        LegendItem(
          label: 'Rest',
          color: scheme.onSurface.withValues(alpha: 0.45),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
