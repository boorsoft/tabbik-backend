import { db } from "../../../db/db";
import { userTournamentTeamInvitation } from "../../../db/schema/tournament";
import { UserTournamentTeamInvitation } from "./types";

export async function inviteUserToTournament(
  invitationData: UserTournamentTeamInvitation
) {
  return db
    .insert(userTournamentTeamInvitation)
    .values(invitationData)
    .returning();
}

export async function getUserTeamInvitations() {
  return db.query.userTournamentTeamInvitation.findMany({
    with: {
      tournament: { columns: { id: true, title: true, startDate: true } },
    },
  });
}
