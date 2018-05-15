FROM michaelwetter/ubuntu-1604_jmodelica_trunk

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

RUN mkdir testcase && \
    mkdir testcase/interface && \
    mkdir testcase/models && \
    mkdir testcase/process && \
    mkdir testcase/doc

COPY interface/ testcase/interface/
COPY models/*.fmu testcase/models/
COPY process/ testcase/process/
COPY doc/ testcase/doc/
COPY __init__.py testcase/


