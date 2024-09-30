import { Router, Response, Request } from "express";
import { validateData } from "../../../middleware/validation.middleware";
import { IUserAuthRequest } from "../../../interfaces/IUserAuthRequest";
import {
  getUserTeamInvitations,
  inviteUserToTournament,
} from "./teamInvitations.service";
import { inviteUserToTournamentSchema } from "./validationSchema";

const teamInvitations = Router();

teamInvitations.post(
  "/invite_user",
  validateData(inviteUserToTournamentSchema),
  async (req: IUserAuthRequest, res: Response) => {
    const team = await inviteUserToTournament({
      ...req.body,
      inviterId: req.userId,
    });

    return res.status(200).json(team);
  }
);

teamInvitations.get("/", async (req: Request, res: Response) => {
  const teamInvitations = await getUserTeamInvitations();

  return res.status(200).json(teamInvitations);
});

export default teamInvitations;
