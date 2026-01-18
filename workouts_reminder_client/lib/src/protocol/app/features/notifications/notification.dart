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
import '../../../app/features/day_schedules/day_schedule.dart' as _i2;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i3;

abstract class Notification implements _i1.SerializableModel {
  Notification._({
    this.id,
    this.dayScheduleId,
    this.daySchedule,
    required this.title,
    required this.body,
    required this.scheduledDate,
    required this.payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Notification({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      dayScheduleId: jsonSerialization['dayScheduleId'] as int?,
      daySchedule: jsonSerialization['daySchedule'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.DaySchedule>(
              jsonSerialization['daySchedule'],
            ),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      scheduledDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledDate'],
      ),
      payload: jsonSerialization['payload'] as String,
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

  int? dayScheduleId;

  _i2.DaySchedule? daySchedule;

  String title;

  String body;

  DateTime scheduledDate;

  String payload;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notification',
      if (id != null) 'id': id,
      if (dayScheduleId != null) 'dayScheduleId': dayScheduleId,
      if (daySchedule != null) 'daySchedule': daySchedule?.toJson(),
      'title': title,
      'body': body,
      'scheduledDate': scheduledDate.toJson(),
      'payload': payload,
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

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    int? dayScheduleId,
    _i2.DaySchedule? daySchedule,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         dayScheduleId: dayScheduleId,
         daySchedule: daySchedule,
         title: title,
         body: body,
         scheduledDate: scheduledDate,
         payload: payload,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    Object? dayScheduleId = _Undefined,
    Object? daySchedule = _Undefined,
    String? title,
    String? body,
    DateTime? scheduledDate,
    String? payload,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      dayScheduleId: dayScheduleId is int? ? dayScheduleId : this.dayScheduleId,
      daySchedule: daySchedule is _i2.DaySchedule?
          ? daySchedule
          : this.daySchedule?.copyWith(),
      title: title ?? this.title,
      body: body ?? this.body,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
