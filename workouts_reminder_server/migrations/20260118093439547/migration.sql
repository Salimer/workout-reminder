BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "day_schedule" ALTER COLUMN "weekScheduleId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "notification" ALTER COLUMN "dayScheduleId" DROP NOT NULL;

--
-- MIGRATION VERSION FOR workouts_reminder
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('workouts_reminder', '20260118093439547', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260118093439547', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
