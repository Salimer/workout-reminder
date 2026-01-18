import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:workouts_reminder_client/workouts_reminder_client.dart';
import 'package:workouts_reminder_flutter/core/providers/client.dart';

import 'goal_model.dart';

class ProfileModel {
  final List<GoalModel> goals;
  final String motivation;
  final String characterName;
  final String fitnessLevel; // 'Beginner', 'Intermediate', 'Advanced'
  final String notificationTone; // 'Friendly', 'Tough', 'Funny'

  const ProfileModel({
    required this.goals,
    required this.motivation,
    required this.characterName,
    required this.fitnessLevel,
    required this.notificationTone,
  });

  Map<String, dynamic> toJson() {
    return {
      'goals': goals.map((goal) => goal.toServerGoal()).toList(),
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      goals:
          (json['goals'] as List<dynamic>?)
              ?.map((goalJson) => GoalModel.fromJson(goalJson))
              .toList() ??
          [],
      motivation: json['motivation'] as String? ?? '',
      characterName: json['characterName'] as String? ?? '',
      fitnessLevel: json['fitnessLevel'] as String? ?? 'Beginner',
      notificationTone: json['notificationTone'] as String? ?? 'Friendly',
    );
  }

  factory ProfileModel.empty() {
    return const ProfileModel(
      goals: [],
      motivation: '',
      characterName: '',
      fitnessLevel: 'Beginner',
      notificationTone: 'Friendly',
    );
  }

  ProfileModel copyWith({
    List<GoalModel>? goals,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
  }) {
    return ProfileModel(
      goals: goals ?? this.goals,
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      notificationTone: notificationTone ?? this.notificationTone,
    );
  }

  factory ProfileModel.fromServerProfile(Profile profile) {
    return ProfileModel(
      goals:
          profile.goals
              ?.map((goal) => GoalModel.fromServerGoal(goal))
              .toList() ??
          [],
      motivation: profile.motivation,
      characterName: profile.characterName,
      fitnessLevel: profile.fitnessLevel,
      notificationTone: profile.notificationTone,
    );
  }

  Profile toServer(Ref ref) {
    return Profile(
      authUserId: ref.read(clientProvider).auth.authInfo!.authUserId,
      goals: goals.map((goal) => goal.toServerGoal()).toList(),
      motivation: motivation,
      characterName: characterName,
      fitnessLevel: fitnessLevel,
      notificationTone: notificationTone,
    );
  }
}
