import '../../../generated/protocol.dart';

extension WeekdayEnumX on WeekdayEnum {
  static WeekdayEnum fromDateTimeWeekday(int weekday) {
    return WeekdayEnum.values[weekday - 1];
  }
}
