import { Router } from "express";
import tournaments from "./tournaments/tournaments.controller";
import { authMiddleware } from "../../middleware/auth.middleware";
import teamInvitations from "./teamInvitations/teamInvitations.controller";

const api = Router();

api.use(authMiddleware);

api.use("/tournaments", tournaments);
api.use("/team-invitations", teamInvitations);

export default api;
