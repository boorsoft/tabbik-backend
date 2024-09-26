import { createInsertSchema } from "drizzle-zod";
import { tournament } from "../../../db/schema/tournament";

export const createTournamentSchema = createInsertSchema(tournament).omit({
  ownerId: true,
  isActive: true,
});
