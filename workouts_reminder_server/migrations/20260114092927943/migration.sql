BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "day_schedule" DROP COLUMN "notifications";
ALTER TABLE "day_schedule" ADD COLUMN "_weekScheduleDaysWeekScheduleId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "notification" ADD COLUMN "_dayScheduleNotificationsDayScheduleId" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "progress" DROP COLUMN "weeks";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "week_schedule" DROP COLUMN "days";
ALTER TABLE "week_schedule" ADD COLUMN "_progressWeeksProgressId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "day_schedule"
    ADD CONSTRAINT "day_schedule_fk_0"
    FOREIGN KEY("_weekScheduleDaysWeekScheduleId")
    REFERENCES "week_schedule"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("_dayScheduleNotificationsDayScheduleId")
    REFERENCES "day_schedule"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "week_schedule"
    ADD CONSTRAINT "week_schedule_fk_0"
    FOREIGN KEY("_progressWeeksProgressId")
    REFERENCES "progress"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR workouts_reminder
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('workouts_reminder', '20260114092927943', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260114092927943', "timestamp" = now();

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
