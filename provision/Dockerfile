FROM ubuntu:focal

RUN apt-get update && \
  apt-get -y install python3 python3-pip && \
  pip3 install requests requests_toolbelt && \
  mkdir /usr/src/boptest

ENV PYTHONPATH /usr/src/boptest/provision
ENV BOPTEST_DASHBOARD_SERVER
ENV BOPTEST_DASHBOARD_API_KEY

WORKDIR /usr/src/boptest

CMD [ "python3", "-m", "boptest_submit", "./testcases/"]
