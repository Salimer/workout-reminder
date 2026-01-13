import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/use_cases/app_use_case.dart';
import '../../use_cases/bottom_navigation_use_case.dart';

class HeroContentModel {
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
  final String? secondaryActionLabel;
  final void Function(WidgetRef ref, BuildContext context)? secondaryAction;

  const HeroContentModel({
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
    this.secondaryActionLabel,
    this.secondaryAction,
  });

  factory HeroContentModel.fromStatus(
    DayWorkoutStatusEnum status,
    ColorScheme scheme,
  ) {
    switch (status) {
      case DayWorkoutStatusEnum.performed:
        return HeroContentModel(
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
            ref.read(bottomNavigationUseCaseProvider).goToProgressView();
          },
          secondaryActionLabel: 'Reset status',
          secondaryAction: (ref, context) {
            showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Reset workout?'),
                content: const Text(
                  'Are you sure you want to reset today\'s workout?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () {
                      ref.read(routesProvider).pop();
                      ref.read(appUseCaseProvider).resetTodayWorkout();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            );
          },
        );
      case DayWorkoutStatusEnum.skipped:
        return HeroContentModel(
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
            ref.read(appUseCaseProvider).resetTodayWorkout();
          },
        );
      case DayWorkoutStatusEnum.pending:
        return HeroContentModel(
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
            ref.read(appUseCaseProvider).performTodayWorkout();
          },
          secondaryActionLabel: 'Skip today',
          secondaryAction: (ref, context) {
            showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Hey chill buddy!!!'),
                content: const Text('Why are we skipping today?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back'),
                  ),
                  FilledButton(
                    onPressed: () {
                      ref.read(routesProvider).pop();
                      ref.read(appUseCaseProvider).skipTodayWorkout();
                    },
                    child: const Text('Skip today'),
                  ),
                ],
              ),
            );
          },
        );
      case DayWorkoutStatusEnum.notScheduled:
        return HeroContentModel(
          pillLabel: 'Rest day',
          kicker: 'Recovery counts',
          title: 'Recharge and refuel',
          subtitle: 'Today is open. Use the energy for a reset or mobility.',
          emoji: '🧘‍♂️',
          accent: scheme.tertiary,
          showCta: false,
          ctaLabel: '',
          ctaIcon: Icons.event_available_outlined,
          onPressed: null,
        );
    }
  }
}
