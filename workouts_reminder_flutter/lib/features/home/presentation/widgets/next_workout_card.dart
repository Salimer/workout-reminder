import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/app_card.dart';
import '../state/home_view_state.dart';

class NextWorkoutCard extends ConsumerWidget {
  const NextWorkoutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewStateProvider);
    final nextDay = state.nextWorkoutDay;
    final isScheduled = state.isNotificationsEnabled;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (nextDay == null) {
      // Empty state if no workout scheduled
      return AppCard(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedCalendar03,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "No upcoming workouts this week.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Map Enum to String (Simple version)
    final dayName = nextDay.toString().split('.').last;
    // e.g. WeekdayEnum.monday -> monday. Capitalize it.
    final label = "${dayName[0].toUpperCase()}${dayName.substring(1)}";

    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next workout',
                style: theme.textTheme.titleMedium,
              ),
              if (isScheduled)
                HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification03,
                  size: 16,
                  color: scheme.primary,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label.substring(0, 3), // Mon, Tue...
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ready to crush it?',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'We will remind you.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
