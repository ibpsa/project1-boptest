FROM michaelwetter/ubuntu-1804_jmodelica_trunk

ARG testcase

ENV ROOT_DIR /usr/local
ENV JMODELICA_HOME $ROOT_DIR/JModelica
ENV IPOPT_HOME $ROOT_DIR/Ipopt-3.12.4
ENV SUNDIALS_HOME $JMODELICA_HOME/ThirdParty/Sundials
ENV SEPARATE_PROCESS_JVM /usr/lib/jvm/java-8-openjdk-amd64/
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PYTHONPATH $PYTHONPATH:$JMODELICA_HOME/Python:$JMODELICA_HOME/Python/pymodelica

USER root
# Edit pyfmi to event update at start of simulation for ME2
RUN sed -i "350 i \\\n        if isinstance(self.model, fmi.FMUModelME2):\n            self.model.event_update()" $JMODELICA_HOME/Python/pyfmi/fmi_algorithm_drivers.py

USER developer

WORKDIR $HOME

RUN pip install --user flask-restful==0.3.9 pandas==0.24.2 flask_cors==3.0.10

RUN mkdir models && \
    mkdir doc

COPY testcases/${testcase}/models/*.fmu models/
COPY testcases/${testcase}/doc/ doc/
COPY restapi.py ./
COPY testcase.py ./
COPY version.txt ./

COPY data data/
COPY forecast forecast/
COPY kpis kpis/
ENV PYTHONPATH $PYTHONPATH:$HOME
