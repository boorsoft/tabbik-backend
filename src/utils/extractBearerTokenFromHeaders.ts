import { IncomingHttpHeaders } from "http";

const extractBearerTokenFromHeaders = ({
  authorization,
}: IncomingHttpHeaders) => {
  if (!authorization) {
    throw new Error("Authorization header is missing");
  }

  if (!authorization.startsWith("Bearer")) {
    throw new Error("Authorization header is not in the Bearer scheme");
  }

  return authorization.slice(7);
};

export default extractBearerTokenFromHeaders;
