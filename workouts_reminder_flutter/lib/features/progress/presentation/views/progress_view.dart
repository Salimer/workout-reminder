import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/animated_section.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import '../../../schedule/presentation/state/progress.dart';
import '../../data/models/month_group_model.dart';
import '../widgets/month_schedule_card.dart';
import '../widgets/progress_hero.dart';
import '../widgets/progress_highlights.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, _) {
        // final progress = ProgressModel.init()
        final progress = ref.watch(progressProvider).requireValue;
        final monthGroups = _groupWeeksByMonth(progress.weeks);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 0,
                    child: ProgressHero(scheme: scheme, progress: progress),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 1,
                    child: ProgressHighlights(progress: progress),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: AppAnimatedSection(
                    index: 2,
                    child: Text(
                      'Training calendar',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Each month group is built lazily as a single list item.
                      final group = monthGroups[index];
                      final headerIndex = 3 + (index * 2);
                      final cardIndex = headerIndex + 1;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppAnimatedSection(
                            index: headerIndex,
                            child: Text(
                              DateFormat('MMMM yyyy').format(group.month),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppAnimatedSection(
                            index: cardIndex,
                            child: MonthScheduleCard(
                              month: group.month,
                              weeks: group.weeks,
                              scheme: scheme,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: monthGroups.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<MonthGroupModel> _groupWeeksByMonth(List<WeekScheduleModel> weeks) {
  final groups = <MonthGroupModel>[];
  for (final week in weeks) {
    final monthKey = DateTime(week.createdAt.year, week.createdAt.month);
    if (groups.isEmpty || groups.last.month != monthKey) {
      groups.add(MonthGroupModel(month: monthKey, weeks: [week]));
    } else {
      groups.last.weeks.add(week);
    }
  }
  return groups;
}
