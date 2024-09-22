/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "TournamentJoinRequest" DROP CONSTRAINT "TournamentJoinRequest_firstSpeakerId_fkey";

-- DropForeignKey
ALTER TABLE "TournamentJoinRequest" DROP CONSTRAINT "TournamentJoinRequest_secondSpeakerId_fkey";

-- DropForeignKey
ALTER TABLE "TournamentJudge" DROP CONSTRAINT "TournamentJudge_judgeId_fkey";

-- DropForeignKey
ALTER TABLE "TournamentTeam" DROP CONSTRAINT "TournamentTeam_firstSpeakerId_fkey";

-- DropForeignKey
ALTER TABLE "TournamentTeam" DROP CONSTRAINT "TournamentTeam_secondSpeakerId_fkey";

-- DropForeignKey
ALTER TABLE "TournamentUserSpeakerPoint" DROP CONSTRAINT "TournamentUserSpeakerPoint_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserTournamentTeamInvitation" DROP CONSTRAINT "UserTournamentTeamInvitation_inviterId_fkey";

-- DropForeignKey
ALTER TABLE "UserTournamentTeamInvitation" DROP CONSTRAINT "UserTournamentTeamInvitation_receiverId_fkey";

-- AlterTable
ALTER TABLE "TournamentJoinRequest" ALTER COLUMN "firstSpeakerId" SET DATA TYPE TEXT,
ALTER COLUMN "secondSpeakerId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "TournamentJudge" ALTER COLUMN "judgeId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "TournamentJudgePoint" ALTER COLUMN "judgeId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "TournamentRoom" ALTER COLUMN "judgeId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "TournamentTeam" ALTER COLUMN "firstSpeakerId" SET DATA TYPE TEXT,
ALTER COLUMN "secondSpeakerId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "TournamentUserSpeakerPoint" ALTER COLUMN "userId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "UserTournamentTeamInvitation" ALTER COLUMN "inviterId" SET DATA TYPE TEXT,
ALTER COLUMN "receiverId" SET DATA TYPE TEXT;

-- DropTable
DROP TABLE "User";
