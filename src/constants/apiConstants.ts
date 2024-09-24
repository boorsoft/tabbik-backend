import { Config } from "../config/config";

export class ApiConstants {
  static USER_CUSTOM_DATA = (userId: string) =>
    Config.logtoApi.concat(`/users/${userId}/custom-data`);
}
