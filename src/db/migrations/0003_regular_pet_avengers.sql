DROP TABLE "tournament_join_request";--> statement-breakpoint
ALTER TABLE "user_tournament_team_invitation" ADD COLUMN "tournamentId" integer NOT NULL;--> statement-breakpoint
ALTER TABLE "user_tournament_team_invitation" ADD COLUMN "teamTitle" varchar(130) NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_tournament_team_invitation" ADD CONSTRAINT "user_tournament_team_invitation_tournamentId_tournament_id_fk" FOREIGN KEY ("tournamentId") REFERENCES "public"."tournament"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
