import dotenv from "dotenv";

dotenv.config();

export class Config {
  static databaseUrl = process.env.DATABASE_URL!;
  static logtoEndpoint = process.env.LOGTO_ENDPOINT!;
  static logtoTokenEndpoint = `${this.logtoEndpoint}/oidc/token`;
  static logtoApi = `${this.logtoEndpoint}/api`;
  static logtoAppId = process.env.LOGTO_APP_ID!;
  static logtoAppSecret = process.env.LOGTO_APP_SECRET!;
}
