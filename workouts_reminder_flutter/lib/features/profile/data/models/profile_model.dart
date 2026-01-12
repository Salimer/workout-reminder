class ProfileModel {
  final List<String> goals;
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
      'goals': goals,
      'motivation': motivation,
      'characterName': characterName,
      'fitnessLevel': fitnessLevel,
      'notificationTone': notificationTone,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      goals: List<String>.from(json['goals'] ?? []),
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
    List<String>? goals,
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
}
