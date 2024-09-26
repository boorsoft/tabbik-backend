import { Request, Response, Router } from "express";
import { TournamentService } from "./tournaments.service";

const tournaments = Router();

tournaments.get("/", (req: Request, res: Response) => {
  const tournamentService = new TournamentService();

  res.status(200).json(tournamentService.getAll());
});

export default tournaments;
