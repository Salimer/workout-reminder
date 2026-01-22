import '../../../generated/protocol.dart';

extension DayWorkoutStatusEnumX on DayWorkoutStatusEnum {
  static String fromClient(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'pending';
      case 'performed':
        return 'performed';
      case 'skipped':
        return 'skipped';
      case 'not scheduled':
        return 'notScheduled';
      default:
        throw ArgumentError('Invalid status string: $status');
    }
  }
}
