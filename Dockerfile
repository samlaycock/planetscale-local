FROM node:18-alpine

WORKDIR /usr/src/app

COPY *.json ./
COPY *.yaml ./

RUN npm i -g pnpm
RUN pnpm i

COPY src ./src/

RUN pnpm build

CMD [ "node", "dist/index.js" ]
