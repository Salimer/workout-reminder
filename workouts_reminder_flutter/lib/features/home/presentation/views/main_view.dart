import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/animated_section.dart';
import '../../../schedule/presentation/state/progress.dart';
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
        final activeWeek = ref
            .watch(
              progressProvider.select(
                (value) => value.requireValue.activeWeek,
              ),
            );
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                AppAnimatedSection(
                  index: 0,
                  child: HeroCard(scheme: scheme),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 1,
                  child: const StreakCard(),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 2,
                  child: const NextWorkoutCard(),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 3,
                  child: const MotivationCard(),
                ),
                const SizedBox(height: 16),
                AppAnimatedSection(
                  index: 4,
                  child: ActionsRow(scheme: scheme),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
