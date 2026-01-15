enum WeekdayEnum {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday')
  ;

  final String day;
  const WeekdayEnum(this.day);

  static WeekdayEnum fromString(String day) {
    return WeekdayEnum.values.firstWhere(
      (e) => e.day.toLowerCase() == day.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid day string: $day'),
    );
  }

  static WeekdayEnum fromDateTimeWeekday(int weekday) {
    return WeekdayEnum.values[weekday - 1];
  }

  @override
  String toString() => day;
}

enum DayWorkoutStatusEnum {
  pending('Pending'),
  performed('Performed'),
  skipped('Skipped'),
  notScheduled('Not Scheduled')
  ;

  final String status;
  const DayWorkoutStatusEnum(this.status);

  @override
  String toString() => status;

  static DayWorkoutStatusEnum fromString(String status) {
    return DayWorkoutStatusEnum.values.firstWhere(
      (e) => e.status.toLowerCase() == status.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid status string: $status'),
    );
  }

  static DayWorkoutStatusEnum fromServerStatus(String status) {
    switch (status) {
      case 'pending':
        return DayWorkoutStatusEnum.pending;
      case 'performed':
        return DayWorkoutStatusEnum.performed;
      case 'skipped':
        return DayWorkoutStatusEnum.skipped;
      case 'notScheduled':
        return DayWorkoutStatusEnum.notScheduled;
      default:
        throw ArgumentError('Invalid server status string: $status');
    }
  }
}

enum ProgressItemType {
  hero,
  highlights,
  title,
  monthHeader,
  monthCard,
  spacer,
}
