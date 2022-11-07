FROM ubuntu:focal as prod

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

FROM ubuntu:focal as debug

RUN apt-get update && apt-get -y install ca-certificates curl build-essential
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

RUN mkdir /root/server

COPY web/server/package.json web/server/package-lock.json /root/server/
COPY boptest/version.txt /boptest/

WORKDIR /root/server
RUN npm install
RUN npm install -g nodemon

WORKDIR /root/server
COPY web/server /root/server
RUN npm run build

CMD [ "nodemon", "--inspect=0.0.0.0", "./build/index.js" ]

