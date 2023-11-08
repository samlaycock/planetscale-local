ARG ALPINE_VERSION=3.18

# Build stage (inspired by: https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md)
FROM node:20-alpine${ALPINE_VERSION} AS builder

WORKDIR /build-stage

RUN npm install -g pnpm

COPY package*.json ./
COPY pnpm*.yaml ./
COPY tsconfig.json .

RUN pnpm install

# Copy the the files you need
COPY ./src ./src

RUN pnpm build

###

# Production stage (inspired by: https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md)
FROM alpine:${ALPINE_VERSION}

WORKDIR /usr/src/app

RUN apk add --no-cache libstdc++ dumb-init \
  && addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node \
  && chown node:node ./

COPY --from=builder /usr/local/bin/node /usr/local/bin/
COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

USER node

COPY --from=builder /build-stage/node_modules ./node_modules
COPY --from=builder /build-stage/dist ./dist

CMD ["dumb-init", "node", "dist/index.js"]
