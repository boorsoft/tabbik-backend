/*
  Warnings:

  - You are about to drop the column `tournamentRoundId` on the `TournamentRoundPoint` table. All the data in the column will be lost.
  - Added the required column `judgeId` to the `TournamentJudge` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roundId` to the `TournamentRoundPoint` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'EDITOR', 'USER');

-- DropForeignKey
ALTER TABLE "TournamentRoundPoint" DROP CONSTRAINT "TournamentRoundPoint_tournamentRoundId_fkey";

-- AlterTable
ALTER TABLE "TournamentJudge" ADD COLUMN     "judgeId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "TournamentRoundPoint" DROP COLUMN "tournamentRoundId",
ADD COLUMN     "roundId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "displayName" TEXT,
    "avatar" TEXT,
    "rating" INTEGER NOT NULL,
    "role" "Role" NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "TournamentJoinRequest" ADD CONSTRAINT "TournamentJoinRequest_firstSpeakerId_fkey" FOREIGN KEY ("firstSpeakerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentJoinRequest" ADD CONSTRAINT "TournamentJoinRequest_secondSpeakerId_fkey" FOREIGN KEY ("secondSpeakerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentTeam" ADD CONSTRAINT "TournamentTeam_firstSpeakerId_fkey" FOREIGN KEY ("firstSpeakerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentTeam" ADD CONSTRAINT "TournamentTeam_secondSpeakerId_fkey" FOREIGN KEY ("secondSpeakerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentJudge" ADD CONSTRAINT "TournamentJudge_judgeId_fkey" FOREIGN KEY ("judgeId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentUserSpeakerPoint" ADD CONSTRAINT "TournamentUserSpeakerPoint_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentRoundPoint" ADD CONSTRAINT "TournamentRoundPoint_roundId_fkey" FOREIGN KEY ("roundId") REFERENCES "TournamentRound"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTournamentTeamInvitation" ADD CONSTRAINT "UserTournamentTeamInvitation_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTournamentTeamInvitation" ADD CONSTRAINT "UserTournamentTeamInvitation_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
