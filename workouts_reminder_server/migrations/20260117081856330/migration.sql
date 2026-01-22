BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "goal" (
    "id" bigserial PRIMARY KEY,
    "text" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "_profileGoalsProfileId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "motivation" text NOT NULL,
    "characterName" text NOT NULL,
    "fitnessLevel" text NOT NULL,
    "notificationTone" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "profile_user_unique_idx" ON "profile" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "goal"
    ADD CONSTRAINT "goal_fk_0"
    FOREIGN KEY("_profileGoalsProfileId")
    REFERENCES "profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR workouts_reminder
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('workouts_reminder', '20260117081856330', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260117081856330', "timestamp" = now();

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
