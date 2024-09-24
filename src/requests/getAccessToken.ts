import axios from "axios";
import qs from "qs";
import { Config } from "../config/config";
import { IAccessTokenResponse } from "../interfaces/IAccessTokenResponse";

export const getAccessToken = async (): Promise<IAccessTokenResponse> => {
  return axios
    .post(
      `${Config.logtoTokenEndpoint}`,
      qs.stringify({
        client_id: Config.logtoAppId,
        client_secret: Config.logtoAppSecret,
        grant_type: "client_credentials",
        resource: `${Config.logtoEndpoint}/api`,
        scope: "all",
      }),
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    )
    .then(({ data }) => data);
};
