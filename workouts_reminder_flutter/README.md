# workouts_reminder_flutter

Flutter client for Nudge Fit.

## Prerequisites
- Flutter SDK (stable)
- Dart SDK (bundled with Flutter)
- The Serverpod backend running locally

## Run the app
From this directory:

```bash
flutter pub get
flutter run
```

## Notes
- The app expects the Serverpod server to be running. See `../workouts_reminder_server/README.md`.
- Local notifications are scheduled on-device using `flutter_local_notifications`.
