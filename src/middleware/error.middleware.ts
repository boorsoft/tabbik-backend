import { NextFunction, Request, Response } from "express";
import { ApiError } from "../utils/apiError";

const errorMiddleware = (
  err: ApiError | Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const statusCode = err instanceof ApiError ? err.statusCode : 500;
  const message = err.message || "Something went wrong";

  if (process.env.NODE_ENV !== "production") {
    console.error("Error: ", err);
  }

  res.status(statusCode).json({
    status: "error",
    statusCode,
    message,
    stack: process.env.NODE_ENV !== "production" ? "0" : err.stack,
  });
};

export default errorMiddleware;
