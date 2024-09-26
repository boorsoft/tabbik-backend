import { Pool } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";
import { Config } from "../config/config";

import * as tournamentSchema from "./schema/tournament";

const pool = new Pool({
  connectionString: Config.databaseUrl,
});

export const db = drizzle(pool, { schema: { ...tournamentSchema } });
