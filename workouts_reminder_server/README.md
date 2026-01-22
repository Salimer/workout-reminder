# workouts_reminder_server

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres. Redis is optional unless you use Serverpod features that rely on it. It's easiest to do with Docker.

    docker compose up --build --detach

Then you can start the Serverpod server.

    dart bin/main.dart

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop the services.

    docker compose stop
