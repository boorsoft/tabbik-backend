import { Router } from "express";
import tournaments from "./tournaments/tournaments.controller";

const api = Router();

api.use("/tournaments", tournaments);

export default api;
