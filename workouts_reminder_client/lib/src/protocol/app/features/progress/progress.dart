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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i2;
import '../../../app/features/week_schedules/week_schedule.dart' as _i3;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i4;

abstract class Progress implements _i1.SerializableModel {
  Progress._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Progress({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProgressImpl;

  factory Progress.fromJson(Map<String, dynamic> jsonSerialization) {
    return Progress(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      weeks: jsonSerialization['weeks'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.WeekSchedule>>(
              jsonSerialization['weeks'],
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

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  List<_i3.WeekSchedule>? weeks;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Progress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Progress copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    List<_i3.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Progress',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (weeks != null) 'weeks': weeks?.toJson(valueToJson: (v) => v.toJson()),
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

class _ProgressImpl extends Progress {
  _ProgressImpl({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.WeekSchedule>? weeks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         weeks: weeks,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Progress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Progress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? weeks = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Progress(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      weeks: weeks is List<_i3.WeekSchedule>?
          ? weeks
          : this.weeks?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
