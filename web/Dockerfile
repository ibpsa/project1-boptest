FROM ubuntu:trusty

RUN apt-get update && apt-get -y install ca-certificates curl python-software-properties build-essential git
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y ca-certificates nodejs

RUN mkdir /root/server && mkdir /root/app

COPY server/package.json server/package-lock.json /root/server/
COPY app/package.json app/package-lock.json /root/app/

WORKDIR /root/server
RUN npm install

WORKDIR /root/app
RUN npm install

ARG NODE_ENV

WORKDIR /root/app
COPY app /root/app
RUN npm run build

WORKDIR /root/server
COPY server /root/server
RUN npm run build

RUN mv /root/app/build /root/server/build/app

CMD [ "npm", "start" ]
