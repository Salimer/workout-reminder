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
import '../../../app/features/profile/goal.dart' as _i3;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i4;

abstract class Profile implements _i1.SerializableModel {
  Profile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.goals,
    required this.motivation,
    required this.characterName,
    required this.fitnessLevel,
    required this.notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Profile({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      goals: jsonSerialization['goals'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.Goal>>(
              jsonSerialization['goals'],
            ),
      motivation: jsonSerialization['motivation'] as String,
      characterName: jsonSerialization['characterName'] as String,
      fitnessLevel: jsonSerialization['fitnessLevel'] as String,
      notificationTone: jsonSerialization['notificationTone'] as String,
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

  List<_i3.Goal>? goals;

  String motivation;

  String characterName;

  String fitnessLevel;

  String notificationTone;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Profile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (goals != null) 'goals': goals?.toJson(valueToJson: (v) => v.toJson()),
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
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

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    List<_i3.Goal>? goals,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         goals: goals,
         motivation: motivation,
         characterName: characterName,
         fitnessLevel: fitnessLevel,
         notificationTone: notificationTone,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? goals = _Undefined,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      goals: goals is List<_i3.Goal>?
          ? goals
          : this.goals?.map((e0) => e0.copyWith()).toList(),
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      notificationTone: notificationTone ?? this.notificationTone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
