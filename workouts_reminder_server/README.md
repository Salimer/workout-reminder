# workouts_reminder_server

Serverpod backend for Nudge Fit.

## Prerequisites
- Docker (for Postgres)
- Dart SDK

## Run the server
Start Postgres (Redis is optional unless you use Serverpod features that rely on it):

```bash
docker compose up --build --detach
```

Then run the Serverpod server:

```bash
dart bin/main.dart
```

## Configuration
- Passwords live in `config/passwords.yaml` and are loaded via `session.passwords`.
- AI notifications use `shared.geminiKey`. If it’s missing, AI copy generation is skipped.

## Stop services
Shut down Serverpod with `Ctrl-C`, then:

```bash
docker compose stop
```
