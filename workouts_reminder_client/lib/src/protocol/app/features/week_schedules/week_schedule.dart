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

abstract class WeekSchedule implements _i1.SerializableModel {
  WeekSchedule._({
    this.id,
    required this.days,
    required this.deadline,
    this.note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WeekSchedule({
    int? id,
    required List<_i2.DaySchedule> days,
    required DateTime deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WeekScheduleImpl;

  factory WeekSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeekSchedule(
      id: jsonSerialization['id'] as int?,
      days: _i3.Protocol().deserialize<List<_i2.DaySchedule>>(
        jsonSerialization['days'],
      ),
      deadline: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      note: jsonSerialization['note'] as String?,
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

  List<_i2.DaySchedule> days;

  DateTime deadline;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WeekSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeekSchedule copyWith({
    int? id,
    List<_i2.DaySchedule>? days,
    DateTime? deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeekSchedule',
      if (id != null) 'id': id,
      'days': days.toJson(valueToJson: (v) => v.toJson()),
      'deadline': deadline.toJson(),
      if (note != null) 'note': note,
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

class _WeekScheduleImpl extends WeekSchedule {
  _WeekScheduleImpl({
    int? id,
    required List<_i2.DaySchedule> days,
    required DateTime deadline,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         days: days,
         deadline: deadline,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WeekSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeekSchedule copyWith({
    Object? id = _Undefined,
    List<_i2.DaySchedule>? days,
    DateTime? deadline,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WeekSchedule(
      id: id is int? ? id : this.id,
      days: days ?? this.days.map((e0) => e0.copyWith()).toList(),
      deadline: deadline ?? this.deadline,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
