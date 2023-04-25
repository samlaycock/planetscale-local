import env from "env-var";

export const MYSQL_URL = env.get("MYSQL_URL").required().asUrlString();
export const PORT = env.get("PORT").default("8080").asPortNumber();
