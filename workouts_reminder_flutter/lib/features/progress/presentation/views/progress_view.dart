import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../schedule/data/models/day_schedule_model.dart';
import '../../../schedule/data/models/week_schedule_model.dart';
import '../../data/models/progress_model.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = ProgressModel.init();
    final scheme = Theme.of(context).colorScheme;
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
              case _ProgressItemType.weekCard:
                child = _WeekScheduleCard(
                  week: item.week!,
                  scheme: scheme,
                );
                break;
              case _ProgressItemType.legend:
                child = const _CalendarLegend();
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
    for (final week in group.weeks) {
      items.add(_ProgressListItem.weekCard(week, animationIndex++));
      items.add(const _ProgressListItem.spacer(12));
    }
  }

  items.add(const _ProgressListItem.spacer(8));
  items.add(_ProgressListItem.legend(animationIndex++));

  return items;
}

enum _ProgressItemType {
  hero,
  highlights,
  title,
  monthHeader,
  weekCard,
  legend,
  spacer,
}

class _ProgressListItem {
  final _ProgressItemType type;
  final int? animationIndex;
  final DateTime? month;
  final WeekScheduleModel? week;
  final double? spacing;

  const _ProgressListItem._({
    required this.type,
    this.animationIndex,
    this.month,
    this.week,
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

  factory _ProgressListItem.weekCard(
    WeekScheduleModel week,
    int animationIndex,
  ) => _ProgressListItem._(
    type: _ProgressItemType.weekCard,
    animationIndex: animationIndex,
    week: week,
  );

  factory _ProgressListItem.legend(int animationIndex) => _ProgressListItem._(
    type: _ProgressItemType.legend,
    animationIndex: animationIndex,
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

class _WeekScheduleCard extends StatelessWidget {
  const _WeekScheduleCard({required this.week, required this.scheme});

  final WeekScheduleModel week;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final rangeText = _formatRange(week.createdAt, week.deadline);
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
                      week.note,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rangeText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: week.isCompleted
                      ? Colors.green.withValues(alpha: 0.15)
                      : scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  week.isCompleted ? 'Completed' : 'Active',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: week.isCompleted ? Colors.green : scheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: week.days
                .map(
                  (day) => _DayChip(
                    day: day,
                    scheme: scheme,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.day, required this.scheme});

  final DayScheduleModel day;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final style = _DayStyle.fromStatus(day.status, scheme);
    final bool isCompleted = day.status == DayWorkoutStatusEnum.performed;
    return Container(
      width: 46,
      height: 58,
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: style.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.day.day.substring(0, 3).toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: style.text,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: isCompleted ? style.accent : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: style.accent,
                width: isCompleted ? 0 : 2,
              ),
            ),
            child: isCompleted
                ? Icon(
                    Icons.check,
                    size: 10,
                    color: scheme.onPrimary,
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
          background: Colors.green.withValues(alpha: 0.15),
          border: Colors.green.withValues(alpha: 0.3),
          text: Colors.green.shade800,
          accent: Colors.green,
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
          background: scheme.primary.withValues(alpha: 0.12),
          border: scheme.primary.withValues(alpha: 0.3),
          text: scheme.primary,
          accent: scheme.primary,
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

class _CalendarLegend extends StatelessWidget {
  const _CalendarLegend();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _LegendItem(
          label: 'Scheduled (ring)',
          color: scheme.primary,
        ),
        _LegendItem(
          label: 'Rest',
          color: scheme.onSurface.withValues(alpha: 0.45),
        ),
        const _LegendItem(
          label: 'Completed (check)',
          color: Colors.green,
        ),
        const _LegendItem(
          label: 'Skipped',
          color: Colors.red,
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
