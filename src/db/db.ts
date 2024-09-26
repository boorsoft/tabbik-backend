import { drizzle } from "drizzle-orm/postgres-js";
import { Config } from "../config/config";

import * as tournamentSchema from "./schema/tournament";
import postgres from "postgres";

const sql = postgres(Config.databaseUrl, { ssl: "require", max: 1 });

export const db = drizzle(sql, { schema: { ...tournamentSchema } });
