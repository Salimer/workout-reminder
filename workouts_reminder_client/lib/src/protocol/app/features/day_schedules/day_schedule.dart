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
import '../../../app/core/enums/weekday_enum.dart' as _i2;
import '../../../app/features/notifications/notification.dart' as _i3;
import '../../../app/core/enums/day_workout_status_enum.dart' as _i4;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i5;

abstract class DaySchedule implements _i1.SerializableModel {
  DaySchedule._({
    this.id,
    required this.day,
    this.notifications,
    required this.status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DaySchedule({
    int? id,
    required _i2.WeekdayEnum day,
    List<_i3.Notification>? notifications,
    required _i4.DayWorkoutStatusEnum status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DayScheduleImpl;

  factory DaySchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return DaySchedule(
      id: jsonSerialization['id'] as int?,
      day: _i2.WeekdayEnum.fromJson((jsonSerialization['day'] as String)),
      notifications: jsonSerialization['notifications'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.Notification>>(
              jsonSerialization['notifications'],
            ),
      status: _i4.DayWorkoutStatusEnum.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.WeekdayEnum day;

  List<_i3.Notification>? notifications;

  _i4.DayWorkoutStatusEnum status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DaySchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DaySchedule copyWith({
    int? id,
    _i2.WeekdayEnum? day,
    List<_i3.Notification>? notifications,
    _i4.DayWorkoutStatusEnum? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DaySchedule',
      if (id != null) 'id': id,
      'day': day.toJson(),
      if (notifications != null)
        'notifications': notifications?.toJson(valueToJson: (v) => v.toJson()),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DayScheduleImpl extends DaySchedule {
  _DayScheduleImpl({
    int? id,
    required _i2.WeekdayEnum day,
    List<_i3.Notification>? notifications,
    required _i4.DayWorkoutStatusEnum status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         day: day,
         notifications: notifications,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DaySchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DaySchedule copyWith({
    Object? id = _Undefined,
    _i2.WeekdayEnum? day,
    Object? notifications = _Undefined,
    _i4.DayWorkoutStatusEnum? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DaySchedule(
      id: id is int? ? id : this.id,
      day: day ?? this.day,
      notifications: notifications is List<_i3.Notification>?
          ? notifications
          : this.notifications?.map((e0) => e0.copyWith()).toList(),
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
