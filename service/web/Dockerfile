FROM node:24-bookworm-slim AS build

RUN mkdir /root/server

COPY service/web/server/package.json service/web/server/package-lock.json /root/server/

WORKDIR /root/server
RUN npm ci

COPY service/web/server/.babelrc /root/server/.babelrc
COPY service/web/server/src /root/server/src
RUN npm run build

FROM node:24-bookworm-slim

RUN mkdir /root/server

COPY service/web/server/package.json service/web/server/package-lock.json /root/server/
COPY version.txt /boptest/

WORKDIR /root/server
RUN npm ci --omit=dev

COPY --from=build /root/server/build /root/server/build
COPY service/web/server/docs /root/server/docs

CMD [ "npm", "start" ]
