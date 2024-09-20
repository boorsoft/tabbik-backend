import { createRemoteJWKSet, jwtVerify } from "jose";
import extractBearerTokenFromHeaders from "../utils/extractBearerTokenFromHeaders";
import { NextFunction, Request, Response } from "express";

// Generate a JWKS using jwks_uri obtained from the Logto server
const jwks = createRemoteJWKSet(new URL("https://imfpdu.logto.app/oidc/jwks"));

export const authMiddleware = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  // Extract the token using the helper function defined above
  const token = extractBearerTokenFromHeaders(req.headers);

  const { payload } = await jwtVerify(
    // The raw Bearer Token extracted from the request header
    token,
    jwks,
    {
      // Expected issuer of the token, issued by the Logto server
      issuer: "https://imfpdu.logto.app/oidc",
      // Expected audience token, the resource indicator of the current API
      audience: "localhost:3000",
    }
  );

  // Sub is the user ID, used for user identification
  const { scope, sub } = payload;

  // For role-based access control, we'll discuss it later
  // assert(scope.split(" ").includes("read:products"));

  return next();
};