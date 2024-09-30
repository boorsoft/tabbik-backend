import { userTournamentTeamInvitation } from "../../../db/schema/tournament";

export type UserTournamentTeamInvitation =
  typeof userTournamentTeamInvitation.$inferInsert;
