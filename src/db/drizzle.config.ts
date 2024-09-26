import { defineConfig } from "drizzle-kit";
import { Config } from "../config/config";

export default defineConfig({
  schema: "./schema/*",
  out: "./drizzle",
  dialect: "postgresql",
  dbCredentials: {
    url: Config.databaseUrl,
  },
});
