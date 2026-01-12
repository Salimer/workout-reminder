import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import '../../../schedule/presentation/state/progress.dart';
import '../../data/models/month_group_model.dart';
import '../../data/models/progress_list_item_model.dart';
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
        final items = _buildProgressItems(monthGroups);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                Widget child;
                switch (item.type) {
                  case ProgressItemType.hero:
                    child = ProgressHero(scheme: scheme, progress: progress);
                    break;
                  case ProgressItemType.highlights:
                    child = ProgressHighlights(progress: progress);
                    break;
                  case ProgressItemType.title:
                    child = Text(
                      'Training calendar',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                    break;
                  case ProgressItemType.monthHeader:
                    child = Text(
                      DateFormat('MMMM yyyy').format(item.month!),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                    break;
                  case ProgressItemType.monthCard:
                    child = MonthScheduleCard(
                      month: item.month!,
                      weeks: item.weeks!,
                      scheme: scheme,
                    );
                    break;
                  case ProgressItemType.spacer:
                    return SizedBox(height: item.spacing);
                }

                if (item.animationIndex == null) {
                  return child;
                }

                return AppAnimatedSection(
                  index: item.animationIndex!,
                  child: child,
                );
              },
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

List<ProgressListItemModel> _buildProgressItems(List<MonthGroupModel> groups) {
  final items = <ProgressListItemModel>[];
  var animationIndex = 0;

  items.add(ProgressListItemModel.hero(animationIndex++));
  items.add(const ProgressListItemModel.spacer(16));
  items.add(ProgressListItemModel.highlights(animationIndex++));
  items.add(const ProgressListItemModel.spacer(24));
  items.add(ProgressListItemModel.title(animationIndex++));
  items.add(const ProgressListItemModel.spacer(12));

  for (final group in groups) {
    items.add(ProgressListItemModel.monthHeader(group.month, animationIndex++));
    items.add(const ProgressListItemModel.spacer(8));
    items.add(
      ProgressListItemModel.monthCard(
        group.month,
        group.weeks,
        animationIndex++,
      ),
    );
    items.add(const ProgressListItemModel.spacer(16));
  }

  return items;
}
