import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../profile/presentation/state/profile_state.dart';

part 'coach_message.g.dart';

@Riverpod(keepAlive: true)
String coachMessage(Ref ref) {
  final profile = ref.watch(profileStateProvider).value;
  if (profile == null) return "Let's get moving!";

  final tone = profile.notificationTone;
  final random = Random();

  final friendlyMessages = [
    "Hey! A little movement goes a long way. 🌱",
    "You're doing great. Just show up today!",
    "Listen to your body, but don't ignore it. 🧘",
    "Every step counts. Proud of you!",
  ];

  final toughMessages = [
    "No excuses. Get it done. ⚡️",
    "Soreness is weakness leaving the body.",
    "Do what you said you would do.",
    "Motivation is fleeting. Discipline is everything.",
  ];

  final funnyMessages = [
    "Your gym shoes miss you. Probably. 🤡",
    "Sweat is just your fat crying.",
    "I promise the weights won't bite.",
    "Exercise? I thought you said 'Extra Fries'. Just kidding, go lift.",
  ];

  List<String> messages;
  switch (tone) {
    case 'Tough':
      messages = toughMessages;
      break;
    case 'Funny':
      messages = funnyMessages;
      break;
    default:
      messages = friendlyMessages;
  }

  return messages[random.nextInt(messages.length)];
}
