class UserProfileModel {
  final List<String> goals;
  final String motivation;
  final String characterName;
  final String fitnessLevel; // 'Beginner', 'Intermediate', 'Advanced'
  final String notificationTone; // 'Friendly', 'Tough', 'Funny'

  const UserProfileModel({
    required this.goals,
    required this.motivation,
    required this.characterName,
    required this.fitnessLevel,
    required this.notificationTone,
  });

  Map<String, dynamic> toJson() {
    return {
      'goals': goals,
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      goals: List<String>.from(json['goals'] ?? []),
      motivation: json['motivation'] as String? ?? '',
      characterName: json['characterName'] as String? ?? '',
      fitnessLevel: json['fitnessLevel'] as String? ?? 'Beginner',
      notificationTone: json['notificationTone'] as String? ?? 'Friendly',
    );
  }

  factory UserProfileModel.empty() {
    return const UserProfileModel(
      goals: [],
      motivation: '',
      characterName: '',
      fitnessLevel: 'Beginner',
      notificationTone: 'Friendly',
    );
  }

  UserProfileModel copyWith({
    List<String>? goals,
    String? motivation,
    String? characterName,
    String? fitnessLevel,
    String? notificationTone,
  }) {
    return UserProfileModel(
      goals: goals ?? this.goals,
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      notificationTone: notificationTone ?? this.notificationTone,
    );
  }
}
