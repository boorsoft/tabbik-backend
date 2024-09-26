import { Pool } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";
import { Config } from "../config/config";

const pool = new Pool({
  connectionString: Config.databaseUrl,
});

export const db = drizzle(pool);
