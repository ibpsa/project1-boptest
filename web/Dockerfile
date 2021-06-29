FROM ubuntu:focal

RUN apt-get update && apt-get -y install ca-certificates curl build-essential git
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

RUN mkdir /root/server

COPY server/package.json server/package-lock.json /root/server/

WORKDIR /root/server
RUN npm install

WORKDIR /root/server
COPY server /root/server
RUN npm run build

CMD [ "npm", "start" ]
