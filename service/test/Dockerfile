FROM python:3.8.15-alpine3.15

RUN pip3 install -I \
    pytest==7.3.1 \
    requests==2.28.1 \
    requests-toolbelt==0.10.1 \
    websockets==10.4 \
    pytest-asyncio==0.20.3 \
    pytest-check==2.1.2

COPY provision /provision
COPY boptest/testcases /boptest/testcases
COPY test /test

WORKDIR /test

ENV PYTHONPATH=/provision:/boptest

CMD [ "pytest", "." ]
