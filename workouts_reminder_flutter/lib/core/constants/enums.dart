enum WeekdayEnum {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  final String day;
  const WeekdayEnum(this.day);

  static WeekdayEnum fromString(String day) {
    return WeekdayEnum.values.firstWhere(
      (e) => e.day.toLowerCase() == day.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid day string: $day'),
    );
  }

  @override
  String toString() => day;
}

enum WorkoutsStatusEnum {
  pending,
  started,
  completed,
  skipped,
}
