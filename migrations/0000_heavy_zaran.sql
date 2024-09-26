DO $$ BEGIN
 CREATE TYPE "public"."tournamentRoomPosition" AS ENUM('OPENING_GOVERNMENT', 'CLOSING_GOVERNMENT', 'OPENING_OPPOSITION', 'CLOSING_OPPOSITION');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" varchar(256) NOT NULL,
	"description" text NOT NULL,
	"icon" varchar(256),
	"location" varchar(256) NOT NULL,
	"ownerId" varchar(256) NOT NULL,
	"maxTeams" integer NOT NULL,
	"registrationFee" integer NOT NULL,
	"isActive" boolean DEFAULT false,
	"startDate" timestamp DEFAULT now(),
	"endDate" timestamp NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now(),
	CONSTRAINT "tournament_title_unique" UNIQUE("title")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_join_request" (
	"id" serial PRIMARY KEY NOT NULL,
	"firstSpeakerId" varchar(256) NOT NULL,
	"secondSpeakerId" varchar(256) NOT NULL,
	"teamTitle" varchar(120),
	"isApproved" boolean DEFAULT false,
	"tournamentId" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now(),
	CONSTRAINT "tournament_join_request_teamTitle_unique" UNIQUE("teamTitle")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_judge" (
	"id" serial PRIMARY KEY NOT NULL,
	"judgeId" varchar(256) NOT NULL,
	"tournamentId" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_judge_point" (
	"id" serial PRIMARY KEY NOT NULL,
	"judgeId" varchar(256) NOT NULL,
	"tournamentId" integer NOT NULL,
	"points" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_room" (
	"id" serial PRIMARY KEY NOT NULL,
	"tournamentId" integer NOT NULL,
	"judgeId" varchar(256) NOT NULL,
	"room" integer,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_room_team" (
	"id" serial PRIMARY KEY NOT NULL,
	"teamId" integer NOT NULL,
	"roomId" integer NOT NULL,
	"tournamentRoomPosition" "tournamentRoomPosition",
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_round" (
	"id" serial PRIMARY KEY NOT NULL,
	"round" integer NOT NULL,
	"resolution" text NOT NULL,
	"isClosed" boolean DEFAULT false,
	"tournamentId" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_round_point" (
	"id" serial PRIMARY KEY NOT NULL,
	"roundId" integer NOT NULL,
	"points" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_team" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" varchar(160),
	"firstSpeakerId" varchar NOT NULL,
	"secondSpeakerId" varchar NOT NULL,
	"tournamentId" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tournament_user_speaker_point" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" varchar(256) NOT NULL,
	"tournamentId" integer NOT NULL,
	"speakerPoints" integer NOT NULL,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_tournament_team_invitation" (
	"id" serial PRIMARY KEY NOT NULL,
	"inviterId" varchar(256) NOT NULL,
	"receiverId" varchar(256) NOT NULL,
	"isAccepted" boolean DEFAULT false,
	"createdAt" timestamp DEFAULT now(),
	"updatedAt" timestamp DEFAULT now()
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_join_request" ADD CONSTRAINT "tournament_join_request_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_judge" ADD CONSTRAINT "tournament_judge_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_judge_point" ADD CONSTRAINT "tournament_judge_point_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_room" ADD CONSTRAINT "tournament_room_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_room_team" ADD CONSTRAINT "tournament_room_team_teamId_tournament_team_id_fk" FOREIGN KEY ("teamId") REFERENCES "public"."tournament_team"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_room_team" ADD CONSTRAINT "tournament_room_team_roomId_tournament_room_id_fk" FOREIGN KEY ("roomId") REFERENCES "public"."tournament_room"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_round" ADD CONSTRAINT "tournament_round_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_round_point" ADD CONSTRAINT "tournament_round_point_roundId_tournament_round_id_fk" FOREIGN KEY ("roundId") REFERENCES "public"."tournament_round"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_team" ADD CONSTRAINT "tournament_team_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tournament_user_speaker_point" ADD CONSTRAINT "tournament_user_speaker_point_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "tournamentTitleIdx" ON "tournament" USING btree ("title");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "teamTitleIdx" ON "tournament_join_request" USING btree ("teamTitle");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "resolutionIdx" ON "tournament_round" USING btree ("resolution");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "tournamentTeamTitleIdx" ON "tournament_team" USING btree ("title");