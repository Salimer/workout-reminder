import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../schedule/data/models/day_schedule_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import '../../../schedule/presentation/state/progress.dart';
import '../../data/models/progress_model.dart';

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
                  case _ProgressItemType.hero:
                    child = _ProgressHero(scheme: scheme, progress: progress);
                    break;
                  case _ProgressItemType.highlights:
                    child = _ProgressHighlights(progress: progress);
                    break;
                  case _ProgressItemType.title:
                    child = Text(
                      'Training calendar',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                    break;
                  case _ProgressItemType.monthHeader:
                    child = Text(
                      DateFormat('MMMM yyyy').format(item.month!),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                    break;
                  case _ProgressItemType.monthCard:
                    child = _MonthScheduleCard(
                      month: item.month!,
                      weeks: item.weeks!,
                      scheme: scheme,
                    );
                    break;
                  case _ProgressItemType.spacer:
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

List<_MonthGroup> _groupWeeksByMonth(List<WeekScheduleModel> weeks) {
  final groups = <_MonthGroup>[];
  for (final week in weeks) {
    final monthKey = DateTime(week.createdAt.year, week.createdAt.month);
    if (groups.isEmpty || groups.last.month != monthKey) {
      groups.add(_MonthGroup(month: monthKey, weeks: [week]));
    } else {
      groups.last.weeks.add(week);
    }
  }
  return groups;
}

class _MonthGroup {
  final DateTime month;
  final List<WeekScheduleModel> weeks;

  const _MonthGroup({
    required this.month,
    required this.weeks,
  });
}

List<_ProgressListItem> _buildProgressItems(List<_MonthGroup> groups) {
  final items = <_ProgressListItem>[];
  var animationIndex = 0;

  items.add(_ProgressListItem.hero(animationIndex++));
  items.add(const _ProgressListItem.spacer(16));
  items.add(_ProgressListItem.highlights(animationIndex++));
  items.add(const _ProgressListItem.spacer(24));
  items.add(_ProgressListItem.title(animationIndex++));
  items.add(const _ProgressListItem.spacer(12));

  for (final group in groups) {
    items.add(_ProgressListItem.monthHeader(group.month, animationIndex++));
    items.add(const _ProgressListItem.spacer(8));
    items.add(
      _ProgressListItem.monthCard(group.month, group.weeks, animationIndex++),
    );
    items.add(const _ProgressListItem.spacer(16));
  }

  return items;
}

enum _ProgressItemType {
  hero,
  highlights,
  title,
  monthHeader,
  monthCard,
  spacer,
}

class _ProgressListItem {
  final _ProgressItemType type;
  final int? animationIndex;
  final DateTime? month;
  final List<WeekScheduleModel>? weeks;
  final double? spacing;

  const _ProgressListItem._({
    required this.type,
    this.animationIndex,
    this.month,
    this.weeks,
    this.spacing,
  });

  factory _ProgressListItem.hero(int animationIndex) => _ProgressListItem._(
    type: _ProgressItemType.hero,
    animationIndex: animationIndex,
  );

  factory _ProgressListItem.highlights(int animationIndex) =>
      _ProgressListItem._(
        type: _ProgressItemType.highlights,
        animationIndex: animationIndex,
      );

  factory _ProgressListItem.title(int animationIndex) => _ProgressListItem._(
    type: _ProgressItemType.title,
    animationIndex: animationIndex,
  );

  factory _ProgressListItem.monthHeader(
    DateTime month,
    int animationIndex,
  ) => _ProgressListItem._(
    type: _ProgressItemType.monthHeader,
    animationIndex: animationIndex,
    month: month,
  );

  factory _ProgressListItem.monthCard(
    DateTime month,
    List<WeekScheduleModel> weeks,
    int animationIndex,
  ) => _ProgressListItem._(
    type: _ProgressItemType.monthCard,
    animationIndex: animationIndex,
    month: month,
    weeks: weeks,
  );

  const _ProgressListItem.spacer(double spacing)
    : this._(
        type: _ProgressItemType.spacer,
        spacing: spacing,
      );
}

class _ProgressHero extends StatelessWidget {
  const _ProgressHero({required this.scheme, required this.progress});

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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress.coverage,
                          minHeight: 8,
                          backgroundColor: scheme.onSurface.withValues(
                            alpha: 0.08,
                          ),
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

class _ProgressHighlights extends StatelessWidget {
  const _ProgressHighlights({required this.progress});

  final ProgressModel progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            title: 'Scheduled',
            value: '${progress.scheduledDays}',
            caption: 'Sessions',
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            title: 'Completed',
            value: '${progress.completedDays}',
            caption: 'Sessions',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            title: 'Weeks',
            value: '${progress.plannedWeeks}',
            caption: 'Planned',
            color: scheme.secondary,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.title,
    required this.value,
    required this.caption,
    required this.color,
  });

  final String title;
  final String value;
  final String caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: scheme.onSurface.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: scheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthScheduleCard extends StatelessWidget {
  const _MonthScheduleCard({
    required this.month,
    required this.weeks,
    required this.scheme,
  });

  final DateTime month;
  final List<WeekScheduleModel> weeks;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final scheduledWeeks = weeks.where((week) => week.isSet).toList();
    final inactiveWeeks = weeks.where((week) => !week.isSet).toList();
    final orderedWeeks = [...scheduledWeeks, ...inactiveWeeks];
    final scheduledCount = scheduledWeeks.length;
    final totalCount = weeks.length;

    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 10),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMMM').format(month),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$scheduledCount of $totalCount weeks scheduled',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
              _MonthStatusPill(
                scheduledCount: scheduledCount,
                totalCount: totalCount,
                scheme: scheme,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _InlineLegend(),
          const SizedBox(height: 12),
          Column(
            children: orderedWeeks
                .map(
                  (week) => _WeekMiniRow(
                    week: week,
                    scheme: scheme,
                    isFaded: !week.isSet,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MonthStatusPill extends StatelessWidget {
  const _MonthStatusPill({
    required this.scheduledCount,
    required this.totalCount,
    required this.scheme,
  });

  final int scheduledCount;
  final int totalCount;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isFullyScheduled = scheduledCount == totalCount && totalCount > 0;
    final color = isFullyScheduled ? Colors.green : scheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isFullyScheduled ? 'Locked in' : 'In progress',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
        ),
      ),
    );
  }
}

class _WeekMiniRow extends StatelessWidget {
  const _WeekMiniRow({
    required this.week,
    required this.scheme,
    required this.isFaded,
  });

  final WeekScheduleModel week;
  final ColorScheme scheme;
  final bool isFaded;

  @override
  Widget build(BuildContext context) {
    final rangeText = _formatRange(week.createdAt, week.deadline);
    final opacity = isFaded ? 0.45 : 1.0;
    final scheduledDays = week.days
        .where((day) => day.status != DayWorkoutStatusEnum.notScheduled)
        .length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    week.note,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rangeText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$scheduledDays/7',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: week.days
                  .map((day) => _DayDot(day: day, scheme: scheme))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day, required this.scheme});

  final DayScheduleModel day;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final style = _DayStyle.fromStatus(day.status, scheme);
    final bool isCompleted = day.status == DayWorkoutStatusEnum.performed;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day.day.day.substring(0, 1).toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isCompleted ? style.accent : style.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted ? style.accent : style.border,
              ),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _DayStyle {
  final Color background;
  final Color border;
  final Color text;
  final Color accent;

  const _DayStyle({
    required this.background,
    required this.border,
    required this.text,
    required this.accent,
  });

  factory _DayStyle.fromStatus(
    DayWorkoutStatusEnum status,
    ColorScheme scheme,
  ) {
    switch (status) {
      case DayWorkoutStatusEnum.performed:
        return _DayStyle(
          background: const Color(0xFF12B76A).withValues(alpha: 0.2),
          border: const Color(0xFF12B76A).withValues(alpha: 0.45),
          text: const Color(0xFF0B7A4B),
          accent: const Color(0xFF12B76A),
        );
      case DayWorkoutStatusEnum.skipped:
        return _DayStyle(
          background: Colors.red.withValues(alpha: 0.12),
          border: Colors.red.withValues(alpha: 0.25),
          text: Colors.red.shade700,
          accent: Colors.red,
        );
      case DayWorkoutStatusEnum.pending:
        return _DayStyle(
          background: const Color(0xFF3B82F6).withValues(alpha: 0.16),
          border: const Color(0xFF3B82F6).withValues(alpha: 0.45),
          text: const Color(0xFF1D4ED8),
          accent: const Color(0xFF3B82F6),
        );
      case DayWorkoutStatusEnum.notScheduled:
        return _DayStyle(
          background: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: scheme.onSurface.withValues(alpha: 0.08),
          text: scheme.onSurface.withValues(alpha: 0.6),
          accent: scheme.onSurface.withValues(alpha: 0.35),
        );
    }
  }
}

class _InlineLegend extends StatelessWidget {
  const _InlineLegend();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        _LegendItem(
          label: 'Scheduled',
          color: const Color(0xFF3B82F6),
        ),
        const _LegendItem(
          label: 'Completed',
          color: Color(0xFF12B76A),
        ),
        const _LegendItem(
          label: 'Skipped',
          color: Colors.red,
        ),
        _LegendItem(
          label: 'Rest',
          color: scheme.onSurface.withValues(alpha: 0.45),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatRange(DateTime start, DateTime end) {
  return '${_formatDate(start)} - ${_formatDate(end)}';
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final month = months[date.month - 1];
  return '$month ${date.day}';
}
