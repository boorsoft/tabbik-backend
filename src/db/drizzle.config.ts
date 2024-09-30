import { defineConfig } from "drizzle-kit";
import { Config } from "../config/config";

export default defineConfig({
  schema: "./src/db/schema/*",
  out: "./src/db/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: Config.databaseUrl,
  },
});
