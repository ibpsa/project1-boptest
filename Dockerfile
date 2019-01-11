FROM michaelwetter/ubuntu-1604_jmodelica_trunk

ARG testcase

ENV ROOT_DIR /usr/local
ENV JMODELICA_HOME $ROOT_DIR/JModelica
ENV IPOPT_HOME $ROOT_DIR/Ipopt-3.12.4
ENV SUNDIALS_HOME $JMODELICA_HOME/ThirdParty/Sundials
ENV SEPARATE_PROCESS_JVM /usr/lib/jvm/java-8-openjdk-amd64/
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PYTHONPATH $PYTHONPATH:$JMODELICA_HOME/Python:$JMODELICA_HOME/Python/pymodelica

USER developer

WORKDIR $HOME

RUN pip install --user flask-restful

RUN mkdir models && \
    mkdir doc

COPY ${testcase}/models/*.fmu models/
COPY ${testcase}/models/*.json models/
COPY ${testcase}/doc/ doc/
COPY ${testcase}/config.py ./
COPY restapi.py ./
COPY testcase.py ./


