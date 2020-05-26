FROM boptest

ARG testcase

RUN mkdir models && \
    mkdir doc

COPY testcases/${testcase}/models/*.fmu models/
COPY testcases/${testcase}/doc/ doc/
COPY testcases/${testcase}/config.py ./
COPY restapi.py ./
COPY testcase.py ./

COPY data data/
COPY forecast forecast/
COPY kpis kpis/

ENV PYTHONPATH $PYTHONPATH:$HOME

