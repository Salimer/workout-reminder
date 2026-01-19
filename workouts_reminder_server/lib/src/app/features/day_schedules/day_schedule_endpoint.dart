import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../progress/get_progress_service.dart';
import 'update_day_schedule_status_service.dart';

class DayScheduleEndpoint extends Endpoint {
  final _updateDayScheduleStatusService =
      const UpdateDayScheduleStatusService();
  final _getProgressService = const GetProgressService();

  @override
  bool get requireLogin => true;

  Future<Progress?> updateTodayStatus(
    Session session,
    DayWorkoutStatusEnum status,
    DateTime localDateTime,
  ) async {
    await _updateDayScheduleStatusService.call(
      session,
      status: status,
      localDateTime: localDateTime,
    );
    return _getProgressService.call(session);
  }
}
