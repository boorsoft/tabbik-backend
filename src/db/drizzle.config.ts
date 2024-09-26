import { defineConfig } from "drizzle-kit";
import { Config } from "../config/config";

export default defineConfig({
  schema: "./src/db/schema/*",
  out: "./migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: Config.databaseUrl,
  },
});
