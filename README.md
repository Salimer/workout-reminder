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

## Getting started
### Backend
Follow the Serverpod setup steps in `workouts_reminder_server/README.md`.

### Flutter app
From `workouts_reminder_flutter/`:

```bash
flutter pub get
flutter run
```

## AI configuration
The backend uses a Gemini API key (`geminiKey`) from Serverpod passwords/config. See `workouts_reminder_server/config/` for environment setup.

## Project story
See `PROJECT_STORY.md` for the full hackathon story, challenges, and learnings.
