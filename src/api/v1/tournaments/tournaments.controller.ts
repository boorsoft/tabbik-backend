import { Request, Response, Router } from "express";
import { TournamentService } from "./tournaments.service";

const tournaments = Router();

const tournamentService = new TournamentService();

tournaments.get("/", (req: Request, res: Response) => {
  res.status(200).json(tournamentService.getAll());
});

export default tournaments;
