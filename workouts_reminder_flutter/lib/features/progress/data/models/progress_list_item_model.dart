import '../../../../core/constants/enums.dart';
import '../../../schedule/data/models/week_schedule_model.dart';

class ProgressListItemModel {
  final ProgressItemType type;
  final int? animationIndex;
  final DateTime? month;
  final List<WeekScheduleModel>? weeks;
  final double? spacing;

  const ProgressListItemModel._({
    required this.type,
    this.animationIndex,
    this.month,
    this.weeks,
    this.spacing,
  });

  factory ProgressListItemModel.hero(int animationIndex) =>
      ProgressListItemModel._(
        type: ProgressItemType.hero,
        animationIndex: animationIndex,
      );

  factory ProgressListItemModel.highlights(int animationIndex) =>
      ProgressListItemModel._(
        type: ProgressItemType.highlights,
        animationIndex: animationIndex,
      );

  factory ProgressListItemModel.title(int animationIndex) =>
      ProgressListItemModel._(
        type: ProgressItemType.title,
        animationIndex: animationIndex,
      );

  factory ProgressListItemModel.monthHeader(
    DateTime month,
    int animationIndex,
  ) => ProgressListItemModel._(
    type: ProgressItemType.monthHeader,
    animationIndex: animationIndex,
    month: month,
  );

  factory ProgressListItemModel.monthCard(
    DateTime month,
    List<WeekScheduleModel> weeks,
    int animationIndex,
  ) => ProgressListItemModel._(
    type: ProgressItemType.monthCard,
    animationIndex: animationIndex,
    month: month,
    weeks: weeks,
  );

  const ProgressListItemModel.spacer(double spacing)
    : this._(
        type: ProgressItemType.spacer,
        spacing: spacing,
      );
}
