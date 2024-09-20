-- CreateEnum
CREATE TYPE "TournamentRoomPosition" AS ENUM ('OPENING_GOVERNMENT', 'CLOSING_GOVERNMENT', 'OPENING_OPPOSITION', 'CLOSING_OPPOSITION');

-- CreateTable
CREATE TABLE "Tournament" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "icon" TEXT,
    "location" TEXT NOT NULL,
    "ownerId" INTEGER NOT NULL,
    "isApproved" BOOLEAN NOT NULL DEFAULT false,
    "startDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Tournament_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentJoinRequest" (
    "id" SERIAL NOT NULL,
    "firstSpeakerId" INTEGER NOT NULL,
    "secondSpeakerId" INTEGER NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "teamTitle" TEXT NOT NULL,
    "isApproved" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" BOOLEAN NOT NULL DEFAULT false,
    "updatedAt" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "TournamentJoinRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentTeam" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "firstSpeakerId" INTEGER NOT NULL,
    "secondSpeakerId" INTEGER NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentJudge" (
    "id" SERIAL NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "isMain" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentJudge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentUserSpeakerPoint" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "speakerPoints" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentUserSpeakerPoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentJudgePoint" (
    "id" SERIAL NOT NULL,
    "judgeId" INTEGER NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentJudgePoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentRound" (
    "id" SERIAL NOT NULL,
    "round" INTEGER NOT NULL,
    "resolution" TEXT NOT NULL,
    "isClosed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentRound_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentRoundPoint" (
    "id" SERIAL NOT NULL,
    "tournamentRoundId" INTEGER NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentRoundPoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentRoom" (
    "id" SERIAL NOT NULL,
    "tournamentId" INTEGER NOT NULL,
    "judgeId" INTEGER NOT NULL,
    "room" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentRoom_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentRoomTeam" (
    "id" SERIAL NOT NULL,
    "teamId" INTEGER NOT NULL,
    "roomId" INTEGER NOT NULL,
    "position" "TournamentRoomPosition" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TournamentRoomTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserTournamentTeamInvitation" (
    "id" SERIAL NOT NULL,
    "inviterId" INTEGER NOT NULL,
    "receiverId" INTEGER NOT NULL,
    "isAccepted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserTournamentTeamInvitation_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "TournamentJoinRequest" ADD CONSTRAINT "TournamentJoinRequest_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentTeam" ADD CONSTRAINT "TournamentTeam_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentJudge" ADD CONSTRAINT "TournamentJudge_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentUserSpeakerPoint" ADD CONSTRAINT "TournamentUserSpeakerPoint_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentJudgePoint" ADD CONSTRAINT "TournamentJudgePoint_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentRoundPoint" ADD CONSTRAINT "TournamentRoundPoint_tournamentRoundId_fkey" FOREIGN KEY ("tournamentRoundId") REFERENCES "TournamentRound"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentRoom" ADD CONSTRAINT "TournamentRoom_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "Tournament"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentRoomTeam" ADD CONSTRAINT "TournamentRoomTeam_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "TournamentTeam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentRoomTeam" ADD CONSTRAINT "TournamentRoomTeam_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "TournamentRoom"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
