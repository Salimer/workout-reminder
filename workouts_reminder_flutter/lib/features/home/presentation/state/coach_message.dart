import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/providers/local_time_date.dart';
import '../../../profile/presentation/state/profile_state.dart';
import '../../../progress/presentation/state/progress_state.dart';

part 'coach_message.g.dart';

@riverpod
List<String> coachMessage(Ref ref) {
  final now = ref.read(localTimeDateProvider);
  final progress = ref.watch(progressStateProvider).value;

  if (progress != null && progress.activeWeek != null) {
    final today = WeekdayEnum.fromDateTimeWeekday(now.weekday);
    final daySchedule = progress.activeWeek!.days[today.index];

    if (daySchedule.hasWorkout &&
        daySchedule.notifications != null &&
        daySchedule.notifications!.isNotEmpty) {
      final notifications = daySchedule.notifications!;

      // Filter notifications that have already passed (sent)
      // We use a small buffer or exact comparison.
      // Assuming scheduledDate is in the same timezone context as 'now'.
      final passedNotifications = notifications
          .where((n) => n.scheduledDate.isBefore(now))
          .toList();

      if (passedNotifications.isNotEmpty) {
        return passedNotifications.map((n) => n.body).toList();
      }

      // If no notifications have passed yet (early morning), show the first upcoming one
      // so the widget isn't empty/irrelevant.
      return [notifications.first.body];
    }
  }

  final profile = ref.watch(profileStateProvider).value;
  if (profile == null) return ["Let's get moving!"];

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

  return [messages[random.nextInt(messages.length)]];
}
