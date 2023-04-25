import { json } from "body-parser";
import express from "express";
import morgan from "morgan";

import * as mysql from "./endpoints/mysql";
import { PORT } from "./env";

const app = express();

app.use(morgan("tiny"));
app.use(json());

app.post("/psdb.v1alpha1.Database/Execute", mysql.executeQuery);

app.post("/psdb.v1alpha1.Database/CreateSession", mysql.createSession);

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Planetscale Local listening at http://0.0.0.0:${PORT}`);
});
