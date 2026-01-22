BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "day_schedule" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "day_schedule" (
    "id" bigserial PRIMARY KEY,
    "weekScheduleId" bigint NOT NULL,
    "day" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION DROP TABLE
--
DROP TABLE "notification" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "dayScheduleId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "scheduledDate" timestamp without time zone NOT NULL,
    "payload" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION DROP TABLE
--
DROP TABLE "profile" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "motivation" text NOT NULL,
    "characterName" text NOT NULL,
    "fitnessLevel" text NOT NULL,
    "notificationTone" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "profile_auth_user_unique_idx" ON "profile" USING btree ("authUserId");

--
-- ACTION DROP TABLE
--
DROP TABLE "progress" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "progress" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "progress_auth_user_unique_idx" ON "progress" USING btree ("authUserId");

--
-- ACTION DROP TABLE
--
DROP TABLE "week_schedule" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "week_schedule" (
    "id" bigserial PRIMARY KEY,
    "progressId" bigint NOT NULL,
    "deadline" timestamp without time zone NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "day_schedule"
    ADD CONSTRAINT "day_schedule_fk_0"
    FOREIGN KEY("weekScheduleId")
    REFERENCES "week_schedule"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("dayScheduleId")
    REFERENCES "day_schedule"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "profile"
    ADD CONSTRAINT "profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "progress"
    ADD CONSTRAINT "progress_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "week_schedule"
    ADD CONSTRAINT "week_schedule_fk_0"
    FOREIGN KEY("progressId")
    REFERENCES "progress"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR workouts_reminder
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('workouts_reminder', '20260118092656190', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260118092656190', "timestamp" = now();

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
