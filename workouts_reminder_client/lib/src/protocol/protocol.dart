/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'app/core/enums/day_workout_status_enum.dart' as _i2;
import 'app/core/enums/weekday_enum.dart' as _i3;
import 'app/features/day_schedules/day_schedule.dart' as _i4;
import 'app/features/notifications/notification.dart' as _i5;
import 'app/features/progress/progress.dart' as _i6;
import 'app/features/week_schedules/week_schedule.dart' as _i7;
import 'greeting.dart' as _i8;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i10;
export 'app/core/enums/day_workout_status_enum.dart';
export 'app/core/enums/weekday_enum.dart';
export 'app/features/day_schedules/day_schedule.dart';
export 'app/features/notifications/notification.dart';
export 'app/features/progress/progress.dart';
export 'app/features/week_schedules/week_schedule.dart';
export 'greeting.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.DayWorkoutStatusEnum) {
      return _i2.DayWorkoutStatusEnum.fromJson(data) as T;
    }
    if (t == _i3.WeekdayEnum) {
      return _i3.WeekdayEnum.fromJson(data) as T;
    }
    if (t == _i4.DaySchedule) {
      return _i4.DaySchedule.fromJson(data) as T;
    }
    if (t == _i5.Notification) {
      return _i5.Notification.fromJson(data) as T;
    }
    if (t == _i6.Progress) {
      return _i6.Progress.fromJson(data) as T;
    }
    if (t == _i7.WeekSchedule) {
      return _i7.WeekSchedule.fromJson(data) as T;
    }
    if (t == _i8.Greeting) {
      return _i8.Greeting.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.DayWorkoutStatusEnum?>()) {
      return (data != null ? _i2.DayWorkoutStatusEnum.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.WeekdayEnum?>()) {
      return (data != null ? _i3.WeekdayEnum.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.DaySchedule?>()) {
      return (data != null ? _i4.DaySchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Notification?>()) {
      return (data != null ? _i5.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Progress?>()) {
      return (data != null ? _i6.Progress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.WeekSchedule?>()) {
      return (data != null ? _i7.WeekSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Greeting?>()) {
      return (data != null ? _i8.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<_i5.Notification>) {
      return (data as List)
              .map((e) => deserialize<_i5.Notification>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i5.Notification>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i5.Notification>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i7.WeekSchedule>) {
      return (data as List)
              .map((e) => deserialize<_i7.WeekSchedule>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i7.WeekSchedule>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7.WeekSchedule>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i4.DaySchedule>) {
      return (data as List).map((e) => deserialize<_i4.DaySchedule>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i4.DaySchedule>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i4.DaySchedule>(e))
                    .toList()
              : null)
          as T;
    }
    try {
      return _i9.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.DayWorkoutStatusEnum => 'DayWorkoutStatusEnum',
      _i3.WeekdayEnum => 'WeekdayEnum',
      _i4.DaySchedule => 'DaySchedule',
      _i5.Notification => 'Notification',
      _i6.Progress => 'Progress',
      _i7.WeekSchedule => 'WeekSchedule',
      _i8.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'workouts_reminder.',
        '',
      );
    }

    switch (data) {
      case _i2.DayWorkoutStatusEnum():
        return 'DayWorkoutStatusEnum';
      case _i3.WeekdayEnum():
        return 'WeekdayEnum';
      case _i4.DaySchedule():
        return 'DaySchedule';
      case _i5.Notification():
        return 'Notification';
      case _i6.Progress():
        return 'Progress';
      case _i7.WeekSchedule():
        return 'WeekSchedule';
      case _i8.Greeting():
        return 'Greeting';
    }
    className = _i9.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i10.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'DayWorkoutStatusEnum') {
      return deserialize<_i2.DayWorkoutStatusEnum>(data['data']);
    }
    if (dataClassName == 'WeekdayEnum') {
      return deserialize<_i3.WeekdayEnum>(data['data']);
    }
    if (dataClassName == 'DaySchedule') {
      return deserialize<_i4.DaySchedule>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i5.Notification>(data['data']);
    }
    if (dataClassName == 'Progress') {
      return deserialize<_i6.Progress>(data['data']);
    }
    if (dataClassName == 'WeekSchedule') {
      return deserialize<_i7.WeekSchedule>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i8.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i9.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i10.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i9.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i10.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
