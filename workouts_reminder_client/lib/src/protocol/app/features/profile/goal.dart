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
import '../../../app/features/profile/profile.dart' as _i2;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i3;

abstract class Goal implements _i1.SerializableModel {
  Goal._({
    this.id,
    this.profileId,
    this.profile,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Goal({
    int? id,
    int? profileId,
    _i2.Profile? profile,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GoalImpl;

  factory Goal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Goal(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int?,
      profile: jsonSerialization['profile'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Profile>(
              jsonSerialization['profile'],
            ),
      text: jsonSerialization['text'] as String,
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

  int? profileId;

  _i2.Profile? profile;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Goal copyWith({
    int? id,
    int? profileId,
    _i2.Profile? profile,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Goal',
      if (id != null) 'id': id,
      if (profileId != null) 'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'text': text,
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

class _GoalImpl extends Goal {
  _GoalImpl({
    int? id,
    int? profileId,
    _i2.Profile? profile,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Goal copyWith({
    Object? id = _Undefined,
    Object? profileId = _Undefined,
    Object? profile = _Undefined,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id is int? ? id : this.id,
      profileId: profileId is int? ? profileId : this.profileId,
      profile: profile is _i2.Profile? ? profile : this.profile?.copyWith(),
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
