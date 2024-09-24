/*
  Warnings:

  - You are about to drop the column `isApproved` on the `Tournament` table. All the data in the column will be lost.
  - Added the required column `maxTeams` to the `Tournament` table without a default value. This is not possible if the table is not empty.
  - Added the required column `registrationFee` to the `Tournament` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Tournament" DROP COLUMN "isApproved",
ADD COLUMN     "isActive" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "maxTeams" INTEGER NOT NULL,
ADD COLUMN     "registrationFee" INTEGER NOT NULL,
ALTER COLUMN "ownerId" SET DATA TYPE TEXT;
