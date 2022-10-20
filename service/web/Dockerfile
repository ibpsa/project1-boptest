FROM ubuntu:focal

RUN apt-get update && apt-get -y install ca-certificates curl build-essential
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

RUN mkdir /root/server

COPY web/server/package.json web/server/package-lock.json /root/server/
COPY boptest/version.txt /boptest/

WORKDIR /root/server
RUN npm install

WORKDIR /root/server
COPY web/server /root/server
RUN npm run build

CMD [ "npm", "start" ]
