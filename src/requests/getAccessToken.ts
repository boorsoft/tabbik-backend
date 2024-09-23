import axios from "axios";
import { Config } from "../config/config";

export const getAccessToken = async () => {
  return axios.post(
    Config.logtoEndpoint,
    {
      client_id: Config.logtoAppId,
      client_secret: Config.logtoAppSecret,
      grant_type: "client_credentials",
      resource: `${Config.logtoEndpoint}/api`,
      scope: "all",
    },
    {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    }
  );
};
