FROM python:3.8.15-alpine3.15

RUN pip3 install -I \
    pytest==6.2.5 \
    requests==2.28.1 \
    requests-toolbelt==0.10.1

COPY provision /provision
COPY boptest /boptest
COPY test /test

WORKDIR /test

ENV PYTHONPATH=/provision:/boptest

CMD [ "pytest", "." ]
