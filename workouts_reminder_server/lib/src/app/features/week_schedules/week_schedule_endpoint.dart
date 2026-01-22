import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../progress/get_progress_service.dart';
import 'create_week_schedule_service.dart';
import 'delete_week_schedule_service.dart';
import 'finish_week_schedule_service.dart';
import 'get_week_schedule_service.dart';

class WeekScheduleEndpoint extends Endpoint {
  final _weekScheduleService = const CreateWeekScheduleService();
  final _deleteWeekScheduleService = const DeleteWeekScheduleService();
  final _finishWeekScheduleService = const FinishWeekScheduleService();
  final _getProgressService = const GetProgressService();
  final _getWeekScheduleService = const GetWeekScheduleService();

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
    DateTime localDateTime,
  ) async {
    await _deleteWeekScheduleService.call(session, localDateTime);
    return _getProgressService.call(session);
  }

  Future<Progress?> finishWeek(
    Session session,
    String note,
    DateTime localDateTime,
  ) async {
    await _finishWeekScheduleService.call(
      session,
      note: note,
      localDateTime: localDateTime,
    );
    return _getProgressService.call(session);
  }
}
