import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../progress/presentation/state/progress_state.dart';
import '../../use_cases/bottom_navigation_use_case.dart';
import '../widgets/daily_coach_card.dart';
import '../widgets/hero_card.dart';
import '../widgets/home_header.dart';
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
          progressStateProvider.select(
            (value) => value.requireValue.activeWeek,
          ),
        );

        // PLAN YOUR WEEK STATE
        if (activeWeek == null) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  HomeHeader(
                    onAvatarTap: () => context.goNamed(AppRoutes.profile),
                  ),
                  const SizedBox(height: 24),
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
                ],
              ),
            ),
          );
        }

        // DASHBOARD STATE
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: HomeHeader(
                      onAvatarTap: () => context.goNamed(AppRoutes.profile),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 0,
                    child: HeroCard(scheme: scheme),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 1,
                    child: const DailyCoachCard(),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Stats Grid (Streak + Next Workout)
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 2,
                    child: Column(
                      children: [
                        const StreakCard(),
                        const SizedBox(height: 16),
                        const NextWorkoutCard(),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 3,
                    child: const MotivationCard(),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        );
      },
    );
  }
}
