FROM node:15.3.0-alpine3.12 as builder

WORKDIR /srv/www
COPY . .

RUN npm i \
  && node ace build --production \
  && cd build \
  && npm ci

FROM node:15.3.0-alpine3.12

WORKDIR /srv/www
COPY --from=builder /srv/www/build .

CMD ["node", "server.js"]


