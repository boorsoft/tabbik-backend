import { Router, Response, Request, NextFunction } from "express";
import { validateData } from "../../../middleware/validation.middleware";
import { IUserAuthRequest } from "../../../interfaces/IUserAuthRequest";
import {
  acceptInvitation,
  getTeamInvitationById,
  getUserTeamInvitations,
  inviteUserToTournament,
} from "./teamInvitations.service";
import { inviteUserToTournamentSchema } from "./validationSchema";
import { ApiError } from "../../../utils/apiError";

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

teamInvitations.post(
  "/:id/accept",
  async (req: IUserAuthRequest, res: Response, next: NextFunction) => {
    const { id } = req.params;

    const currentInvitation = await getTeamInvitationById(+id!);

    if (req.userId !== currentInvitation?.receiverId) {
      next(new ApiError("You are not allowed to accept this invitation", 403));
    }

    const invitation = await acceptInvitation(+id!);

    return res.status(200).json(invitation);
  }
);

export default teamInvitations;
