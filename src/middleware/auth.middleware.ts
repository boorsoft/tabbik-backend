import { createRemoteJWKSet, jwtVerify, jwtDecrypt } from "jose";
import extractBearerTokenFromHeaders from "../utils/extractBearerTokenFromHeaders";
import { NextFunction, Request, Response } from "express";
import { ApiError } from "../utils/apiError";
import errorMiddleware from "./error.middleware";
import { IUserAuthRequest } from "../interfaces/IUserAuthRequest";

// Generate a JWKS using jwks_uri obtained from the Logto server
const jwks = createRemoteJWKSet(new URL("https://imfpdu.logto.app/oidc/jwks"));

export const authMiddleware = async (
  req: IUserAuthRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    // Extract the token using the helper function defined above
    const token = extractBearerTokenFromHeaders(req.headers);

    if (!token) throw new ApiError("Not authorized", 401);

    const { payload } = await jwtVerify(
      // The raw Bearer Token extracted from the request header
      token,
      jwks,
      {
        // Expected issuer of the token, issued by the Logto server
        issuer: "https://imfpdu.logto.app/oidc",
        // Expected audience token, the resource indicator of the current API
        // audience: "https://api.tabbik.com/api",
      }
    );

    // Sub is the user ID, used for user identification
    const { scope, sub } = payload;

    req.userId = sub;

    return next();
  } catch (e) {
    errorMiddleware(e as Error, req, res, next);
  }
};
