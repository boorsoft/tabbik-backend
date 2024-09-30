import {
  tournament,
  userTournamentTeamInvitation,
} from "../../../db/schema/tournament";

export type Tournament = typeof tournament.$inferInsert;
