FROM ubuntu:focal

RUN apt-get update && \
  apt-get -y install python3 python3-pip && \
  pip3 install requests requests_toolbelt && \
  mkdir /usr/src/boptest

ENV PYTHONPATH /usr/src/boptest/provision

WORKDIR /usr/src/boptest

CMD [ "python3", "-m", "boptest_submit", "-p", "./boptest/testcases/"]

#parser.add_argument('-a', '--auth-token', required=True)
#parser.add_argument('-s', '--shared', action='store_true')
#parser.add_argument('-d', '--submit-to-dashboard', action='store_true')
#parser.add_argument('-p', '--path', default='./')
