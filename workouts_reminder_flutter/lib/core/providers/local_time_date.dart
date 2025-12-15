import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workouts_reminder_flutter/core/services/notifications_service.dart';

part 'local_time_date.g.dart';

@riverpod
class LocalTimeDate extends _$LocalTimeDate {
  @override
  DateTime build() {
    Timer? timer;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = ref.read(notificationsSvcProvider).localNow;
    });

    ref.onDispose(() {
      timer?.cancel();
    });

    return ref.read(notificationsSvcProvider).localNow;
  }

  String dayName() {
    final now = state;
    switch (now.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
