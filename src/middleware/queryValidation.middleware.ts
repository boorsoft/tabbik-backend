import { Request, Response, NextFunction } from "express";
import { z, ZodError } from "zod";

const validateQuery =
  (schema: z.ZodSchema) =>
  (req: Request, res: Response, next: NextFunction) => {
    try {
      req.query = schema.parse(req.query);
      next();
    } catch (error) {
      if (error instanceof ZodError) {
        return res.status(400).json({
          message: "Invalid query parameters",
          errors: error.errors,
        });
      }
      next(error);
    }
  };

export default validateQuery;
