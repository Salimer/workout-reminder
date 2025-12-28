import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/constants/enums.dart';
import '../../../schedule/presentation/state/progress.dart';
import '../../use_cases/bottom_navigation_use_case.dart';
import '../widgets/actions_row.dart';
import '../widgets/hero_card.dart';
import '../widgets/motivation_card.dart';
import '../widgets/next_workout_card.dart';
import '../widgets/streak_card.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, _) {
        final activeWeek = ref.watch(
          progressProvider.select(
            (value) => value.requireValue.activeWeek,
          ),
        );

        if (activeWeek == null) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  AppAnimatedSection(
                    index: 0,
                    child: AppCard(
                      padding: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          scheme.primary.withValues(alpha: 0.14),
                          scheme.secondary.withValues(alpha: 0.12),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan your week first',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pick the days you want to train so we can schedule reminders and keep you on track.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.75,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () {
                              ref
                                  .read(bottomNavigationUseCaseProvider)
                                  .goToScheduleView();
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                            label: const Text('Plan my week'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppAnimatedSection(
                    index: 1,
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: scheme.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_active_outlined,
                              color: scheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'We’ll send 3 reminders per workout day until you start.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: scheme.onSurface.withValues(
                                      alpha: 0.75,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final dateRange =
            '${DateFormat.MMMd().format(activeWeek.createdAt)} · ${DateFormat.MMMd().format(activeWeek.deadline)}';
        final scheduledDays = activeWeek.days
            .where((day) => day.status != DayWorkoutStatusEnum.notScheduled)
            .length;
        final restDays = WeekdayEnum.values.length - scheduledDays;
        final todayStatus = ref.watch(
          progressProvider.select(
            (value) => value.requireValue.activeWeek!.getTodayStatusEnum(),
          ),
        );

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                AppAnimatedSection(
                  index: 0,
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(18),
                    child: Row(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.event_available_outlined,
                            color: scheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Week planned',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$scheduledDays workouts · $restDays rest days',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: scheme.onSurface.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                dateRange,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: scheme.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(bottomNavigationUseCaseProvider)
                                .goToScheduleView();
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 1,
                  child: HeroCard(scheme: scheme),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 2,
                  child: todayStatus == DayWorkoutStatusEnum.notScheduled
                      ? AppCard(
                          padding: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: scheme.tertiary.withValues(
                                    alpha: 0.12,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.self_improvement_outlined,
                                  color: scheme.tertiary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rest day today',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Recharge and come back strong. We’ll be ready on your next training day.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: scheme.onSurface.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : todayStatus == DayWorkoutStatusEnum.performed
                      ? AppCard(
                          padding: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Workout complete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Nice work today. You’re done for now.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: scheme.onSurface.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ActionsRow(
                          showSkip: todayStatus != DayWorkoutStatusEnum.skipped,
                        ),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 3,
                  child: const StreakCard(),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 4,
                  child: const NextWorkoutCard(),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 5,
                  child: const MotivationCard(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
