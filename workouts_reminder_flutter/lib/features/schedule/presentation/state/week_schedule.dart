import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/week_schedule_model.dart';

part 'week_schedule.g.dart';

@riverpod
class WeekSchedule extends _$WeekSchedule {
  @override
  FutureOr<WeekScheduleModel> build() async {
    return WeekScheduleModel.init();
  }
}
