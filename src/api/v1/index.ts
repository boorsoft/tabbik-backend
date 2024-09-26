import { Router } from "express";
import tournaments from "./tournaments/tournaments.controller";
import { authMiddleware } from "../../middleware/auth.middleware";

const api = Router();

api.use(authMiddleware);

api.use("/tournaments", tournaments);

export default api;
