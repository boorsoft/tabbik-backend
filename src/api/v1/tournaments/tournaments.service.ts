import { eq } from "drizzle-orm";
import { db } from "../../../db/db";
import { tournament } from "../../../db/schema/tournament";
import { Tournament } from "./types";

export async function getTournaments() {
  return db.query.tournament.findMany();
}

export async function getTournamentById(id: number) {
  return db.query.tournament.findFirst({ where: eq(tournament.id, id) });
}

export async function createTournament(data: Tournament) {
  return db.insert(tournament).values(data);
}

export async function updateTournament(id: number, data: Partial<Tournament>) {
  return db.update(tournament).set(data).where(eq(tournament.id, id));
}

export async function deleteTournament(id: number) {
  return db.delete(tournament).where(eq(tournament.id, id));
}
