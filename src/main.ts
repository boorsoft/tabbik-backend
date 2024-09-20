import express, { Application, json, Request, Response } from "express";
import dotenv from "dotenv";
import helmet from "helmet";
import api from "./api/v1";

const app: Application = express();

const port: number = 3000;

dotenv.config();

app.use(helmet());
app.use(json());

app.get("/", (req: Request, res: Response) => {
  res.send("Hello world");
});

app.use("/api/v1", api);

app.listen(port, function () {
  console.log(`App is listening on port ${port} !`);
});
