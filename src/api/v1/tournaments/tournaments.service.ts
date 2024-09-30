import { eq } from "drizzle-orm";
import { tournament } from "../../../db/schema/tournament";
import { Tournament } from "./types";
import { db } from "../../../db/db";

export async function getTournaments() {
  return db.select().from(tournament);
}

export async function getTournamentById(id: number) {
  return db.query.tournament.findFirst({
    where: eq(tournament.id, id),
    with: {
      judges: true,
      teams: true,
      joinRequests: true,
    },
  });
}

export async function createTournament(data: Tournament) {
  return db.insert(tournament).values(data).returning();
}

export async function updateTournament(id: number, data: Partial<Tournament>) {
  return db
    .update(tournament)
    .set(data)
    .where(eq(tournament.id, id))
    .returning();
}

export async function deleteTournament(id: number) {
  return db.delete(tournament).where(eq(tournament.id, id));
}
