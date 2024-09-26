import { eq } from "drizzle-orm";
import { db } from "../../../db/db";
import { tournament } from "../../../db/schema/tournament";
import { Tournament } from "./types";

export class TournamentService {
  constructor() {}

  getAll() {
    return db.query.tournament.findMany();
  }

  create(data: Tournament) {
    return db.insert(tournament).values(data);
  }

  update(id: number, data: Partial<Tournament>) {
    return db.update(tournament).set(data).where(eq(tournament.id, id));
  }

  delete(id: number) {
    return db.delete(tournament).where(eq(tournament.id, id));
  }
}
