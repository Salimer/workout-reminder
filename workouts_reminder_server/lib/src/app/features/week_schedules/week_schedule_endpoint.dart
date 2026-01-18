import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../progress/get_progress_service.dart';
import 'create_week_schedule_service.dart';
import 'delete_week_schedule_service.dart';
import 'get_week_schedule_service.dart';

class WeekScheduleEndpoint extends Endpoint {
  final CreateWeekScheduleService _weekScheduleService =
      const CreateWeekScheduleService();
  final DeleteWeekScheduleService _deleteWeekScheduleService =
      const DeleteWeekScheduleService();
  final GetProgressService _getProgressService = const GetProgressService();
  final GetWeekScheduleService _getWeekScheduleService =
      const GetWeekScheduleService();

  @override
  bool get requireLogin => true;

  Future<WeekSchedule?> createWeekSchedule(
    Session session,
    WeekSchedule weekSchedule,
  ) async {
    final weekScheduleId = await _weekScheduleService.call(
      session,
      weekSchedule,
    );
    return _getWeekScheduleService.call(session, weekScheduleId);
  }

  Future<Progress?> deleteWeekSchedule(
    Session session,
    int weekScheduleId,
  ) async {
    await _deleteWeekScheduleService.call(session, weekScheduleId);
    return _getProgressService.call(session);
  }
}
