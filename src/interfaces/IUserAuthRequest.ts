import { Request } from "express";

export interface IUserAuthRequest extends Request {
  userId?: string;
}
