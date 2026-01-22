# Nudge Fit

A Flutter + Serverpod app that keeps you consistent by sending personalized, AI-generated workout nudges based on your own motivations and goals.

## Features
- Weekly workout scheduling with day-by-day status (pending/performed/skipped)
- Personalized AI notification copy tied to user profile data
- On-device notification scheduling with timezone support
- Streak and progress visualization

## Tech stack
- **Flutter** / **Dart**
- **Serverpod** (backend + data models)
- **PostgreSQL**
- **Gemini API** (notification copy generation)
- **flutter_local_notifications** + **timezone**
- **Riverpod**

## Repo layout
- `workouts_reminder_flutter/` Flutter client
- `workouts_reminder_server/` Serverpod backend
- `workouts_reminder_client/` Generated client package
- `PROJECT_STORY.md` Hackathon project story

## Run the project locally
### 1) Start the backend (Serverpod)
From `workouts_reminder_server/`:

```bash
docker compose up --build --detach
dart bin/main.dart
```

### 2) Run the Flutter app
From `workouts_reminder_flutter/`:

```bash
flutter pub get
flutter run
```

### 3) (Optional) Configure AI notifications
Add a Gemini API key under `shared.geminiKey` in `workouts_reminder_server/config/passwords.yaml`.
If it’s missing, the backend skips AI copy generation and uses default notification text.

## Notes
- Stop the backend with `Ctrl-C`, then `docker compose stop` in `workouts_reminder_server/`.
- See `workouts_reminder_server/README.md` and `workouts_reminder_flutter/README.md` for module-specific details.

## Project story
See `PROJECT_STORY.md` for the full hackathon story, challenges, and learnings.
