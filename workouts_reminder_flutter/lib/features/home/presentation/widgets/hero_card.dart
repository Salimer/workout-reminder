import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/core/providers/local_time_date.dart';
import 'package:workouts_reminder_flutter/features/workout/use_cases/workout_use_case.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../schedule/presentation/state/week_schedule.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          scheme.primary.withValues(alpha: 0.12),
          scheme.secondary.withValues(alpha: 0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Consumer(
        builder: (context, ref, _) {
          final today = ref.read(localTimeDateProvider).weekday;
          final DayWorkoutStatusEnum dayStatus = ref.watch(
            weekScheduleProvider.select(
              (value) => value.requireValue.days[today].status,
            ),
          );
          final hero = _HeroContent.fromStatus(dayStatus, scheme);
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: hero.accent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: hero.accent.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            hero.pillLabel,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: hero.accent,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            hero.kicker,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      hero.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: scheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hero.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                    if (hero.showCta) ...[
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          hero.onPressed?.call(ref);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hero.accent,
                          foregroundColor: scheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          shadowColor: hero.accent.withValues(alpha: 0.35),
                          elevation: 6,
                        ),
                        icon: Icon(hero.ctaIcon, size: 18),
                        label: Text(
                          hero.ctaLabel,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 140,
                width: 110,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: hero.accent.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    hero.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroContent {
  final String pillLabel;
  final String kicker;
  final String title;
  final String subtitle;
  final String emoji;
  final String ctaLabel;
  final IconData ctaIcon;
  final Color accent;
  final bool showCta;
  final void Function(WidgetRef ref)? onPressed;

  const _HeroContent({
    required this.pillLabel,
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.ctaLabel,
    required this.ctaIcon,
    required this.accent,
    required this.showCta,
    required this.onPressed,
  });

  factory _HeroContent.fromStatus(
    DayWorkoutStatusEnum status,
    ColorScheme scheme,
  ) {
    switch (status) {
      case DayWorkoutStatusEnum.performed:
        return _HeroContent(
          pillLabel: 'Completed',
          kicker: 'You\'re on a roll',
          title: 'Workout locked in',
          subtitle: 'Nice work today. Keep the streak glowing.',
          emoji: '✅',
          ctaLabel: 'See progress',
          ctaIcon: Icons.show_chart,
          accent: Colors.green,
          showCta: true,
          onPressed: (ref) {
            ref.read(workoutUseCaseProvider).unScheduleDayWorkout();
          },
        );
      case DayWorkoutStatusEnum.skipped:
        return _HeroContent(
          pillLabel: 'Skipped',
          kicker: 'Reset with intention',
          title: 'We’ll bounce back',
          subtitle: 'No stress. Pick the next session and keep the rhythm.',
          emoji: '🌤️',
          ctaLabel: 'Reschedule',
          ctaIcon: Icons.calendar_today_outlined,
          accent: Colors.orange,
          showCta: true,
          onPressed: (ref) {
            ref.read(workoutUseCaseProvider).resetDayWorkout();
          },
        );
      case DayWorkoutStatusEnum.pending:
        return _HeroContent(
          pillLabel: 'Scheduled',
          kicker: 'Let’s move',
          title: 'Your workout awaits',
          subtitle: 'Tap start and we’ll hype you with smart nudges.',
          emoji: '🏋️‍♂️',
          ctaLabel: 'Start workout',
          ctaIcon: Icons.play_arrow_rounded,
          accent: scheme.primary,
          showCta: true,
          onPressed: (ref) {
            ref.read(workoutUseCaseProvider).performWorkoutAction();
          },
        );
      case DayWorkoutStatusEnum.notScheduled:
        return _HeroContent(
          pillLabel: 'Rest day',
          kicker: 'Recovery counts',
          title: 'Recharge and refuel',
          subtitle: 'Today is open. Use the energy for a reset or mobility.',
          emoji: '🧘‍♂️',
          ctaLabel: 'Plan the week',
          ctaIcon: Icons.event_available_outlined,
          accent: scheme.tertiary,
          showCta: true,
          onPressed: (ref) {
            ref.read(workoutUseCaseProvider).skipDayWorkout();
          },
        );
    }
  }
}
