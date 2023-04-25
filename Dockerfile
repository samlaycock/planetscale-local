FROM node:18

WORKDIR /usr/src/app

COPY *.json ./

RUN npm i

COPY src ./src/

RUN npm run build

CMD [ "node", "dist/index.js" ]
