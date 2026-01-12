import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';
import '../../data/models/progress_model.dart';

class ProgressHero extends StatelessWidget {
  const ProgressHero({
    required this.scheme,
    required this.progress,
    super.key,
  });

  final ColorScheme scheme;
  final ProgressModel progress;

  @override
  Widget build(BuildContext context) {
    final coveragePercent = (progress.coverage * 100).round();
    return AppCard(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          scheme.primary.withValues(alpha: 0.18),
          scheme.secondary.withValues(alpha: 0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress pulse',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            progress.plannedWeeks == 0
                ? 'Set your plan for the week and start building consistency.'
                : 'This week is planned. Keep the momentum rolling.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.12),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Completion rate',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$coveragePercent% complete',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress.coverage,
                          minHeight: 8,
                          backgroundColor:
                              scheme.onSurface.withValues(alpha: 0.08),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        scheme.primary,
                        scheme.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$coveragePercent%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
