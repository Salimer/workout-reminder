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
import '../../../app/features/profile/goal.dart' as _i2;
import 'package:workouts_reminder_client/src/protocol/protocol.dart' as _i3;

abstract class Profile implements _i1.SerializableModel {
  Profile._({
    this.id,
    required this.userId,
    required this.motivation,
    required this.characterName,
    required this.fitnessLevel,
    required this.notificationTone,
    this.goals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Profile({
    int? id,
    required _i1.UuidValue userId,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    List<_i2.Goal>? goals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      motivation: jsonSerialization['motivation'] as String,
      characterName: jsonSerialization['characterName'] as String,
      fitnessLevel: jsonSerialization['fitnessLevel'] as String,
      notificationTone: jsonSerialization['notificationTone'] as String,
      goals: jsonSerialization['goals'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.Goal>>(
              jsonSerialization['goals'],
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

  _i1.UuidValue userId;

  String motivation;

  String characterName;

  String fitnessLevel;

  String notificationTone;

  List<_i2.Goal>? goals;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Profile copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    List<_i2.Goal>? goals,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
      if (goals != null) 'goals': goals?.toJson(valueToJson: (v) => v.toJson()),
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
    required _i1.UuidValue userId,
    required String motivation,
    required String characterName,
    required String fitnessLevel,
    required String notificationTone,
    List<_i2.Goal>? goals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         motivation: motivation,
         characterName: characterName,
         fitnessLevel: fitnessLevel,
         notificationTone: notificationTone,
         goals: goals,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
    Object? goals = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      notificationTone: notificationTone ?? this.notificationTone,
      goals: goals is List<_i2.Goal>?
          ? goals
          : this.goals?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
