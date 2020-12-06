# Builder use to install deps & Build the code
FROM node:15.3.0-alpine3.12 as builder

RUN apk add --no-cache git
WORKDIR /srv/www
COPY . .

RUN npm i \
  && node ace build --production \
  && cd build \
  && npm ci --production

# Application Runtime
FROM node:15.3.0-alpine3.12

USER node
WORKDIR /srv/www
COPY --from=builder /srv/www/build .

EXPOSE 8080
CMD ["node", "server.js"]


