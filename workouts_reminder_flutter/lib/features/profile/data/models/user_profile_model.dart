class UserProfileModel {
  final List<String> goals;
  final String motivation;
  final String characterName;

  const UserProfileModel({
    required this.goals,
    required this.motivation,
    required this.characterName,
  });

  Map<String, dynamic> toJson() {
    return {
      'goals': goals,
      'motivation': motivation,
      'characterName': characterName,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      goals: List<String>.from(json['goals'] ?? []),
      motivation: json['motivation'] as String? ?? '',
      characterName: json['characterName'] as String? ?? '',
    );
  }

  factory UserProfileModel.empty() {
    return const UserProfileModel(
      goals: [],
      motivation: '',
      characterName: '',
    );
  }

  UserProfileModel copyWith({
    List<String>? goals,
    String? motivation,
    String? characterName,
  }) {
    return UserProfileModel(
      goals: goals ?? this.goals,
      motivation: motivation ?? this.motivation,
      characterName: characterName ?? this.characterName,
    );
  }
}
