import { Request, Response, Router } from "express";
import {
  createTournament,
  getTournamentById,
  getTournaments,
} from "./tournaments.service";
import { validateData } from "../../../middleware/validation.middleware";
import { createTournamentSchema } from "./validationSchema";

const tournaments = Router();

tournaments.get("/", async (req: Request, res: Response) => {
  const tournaments = await getTournaments();

  res.status(200).json(tournaments);
});

tournaments.get("/:id", async (req: Request, res: Response) => {
  const { id } = req.params;

  const tournament = await getTournamentById(+id!);

  res.status(200).json(tournament);
});

tournaments.post(
  "/",
  validateData(createTournamentSchema),
  async (req: Request, res: Response) => {
    const newTournament = await createTournament(req.body);

    res.status(200).json(newTournament);
  }
);

export default tournaments;
