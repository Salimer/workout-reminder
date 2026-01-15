import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../progress/presentation/state/progress_state.dart';
import '../../data/models/hero_content_model.dart';

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
          DayWorkoutStatusEnum dayStatus;
          final activeWeek = ref.watch(
            progressStateProvider.select(
              (value) => value.requireValue.activeWeek,
            ),
          );
          if (activeWeek != null) {
            dayStatus = ref.watch(
              progressStateProvider.select(
                (value) => value.requireValue.activeWeek!.getTodayStatusEnum(),
              ),
            );
          } else {
            dayStatus = DayWorkoutStatusEnum.notScheduled;
          }

          final hero = HeroContentModel.fromStatus(dayStatus, scheme);
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
                    if (hero.secondaryAction != null) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => hero.secondaryAction!(ref, context),
                        style: TextButton.styleFrom(
                          foregroundColor: scheme.error,
                        ),
                        child: Text(
                          hero.secondaryActionLabel ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
