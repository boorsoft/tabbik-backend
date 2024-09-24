import axios from "axios";
import { ApiConstants } from "../constants/apiConstants";
import { IUserCustomData } from "../interfaces/IUserCustomData";

export const getUserCustomData = async (
  userId: string
): Promise<IUserCustomData | {}> => {
  return axios
    .get(ApiConstants.USER_CUSTOM_DATA(userId))
    .then(({ data }) => data);
};

export const updateUserCustomData = async (
  userId: string,
  data: IUserCustomData
): Promise<IUserCustomData | {}> => {
  return axios
    .patch(ApiConstants.USER_CUSTOM_DATA(userId), { customData: data })
    .then(({ data }) => data);
};
