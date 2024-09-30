ALTER TABLE "tournament" ALTER COLUMN "isActive" SET DEFAULT true;--> statement-breakpoint
ALTER TABLE "tournament" ADD COLUMN "isRunning" boolean DEFAULT false;