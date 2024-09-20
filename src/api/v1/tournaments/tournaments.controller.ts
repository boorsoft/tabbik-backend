import { Request, Response, Router } from "express";

const tournaments = Router();

tournaments.get("/", (req: Request, res: Response) => {
  res.send("Tournaments logic will be here");
});

export default tournaments;
