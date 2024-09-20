import { Request, Response, Router } from "express";
import { authMiddleware } from "../../../middleware/auth.middleware";

const tournaments = Router();

tournaments.use(authMiddleware);

tournaments.get("/", (req: Request, res: Response) => {
  res.send("Tournaments logic will be here");
});

export default tournaments;
