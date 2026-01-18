import 'package:workouts_reminder_client/workouts_reminder_client.dart';

class GoalModel {
  final String text;

  GoalModel({required this.text});

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      text: json['text'] as String,
    );
  }

  factory GoalModel.fromServerGoal(Goal goal) {
    return GoalModel(
      text: goal.text,
    );
  }

  Goal toServerGoal() {
    return Goal(
      text: text,
    );
  }
}