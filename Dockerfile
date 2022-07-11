FROM michaelwetter/ubuntu-1804_jmodelica_trunk

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

# Install commands for Spawn
ENV SPAWN_VERSION=0.3.0-8d93151657
RUN wget https://spawn.s3.amazonaws.com/custom/Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && tar -xzf Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && ln -s /Spawn-$SPAWN_VERSION-Linux/bin/spawn-$SPAWN_VERSION /usr/local/bin/

USER developer

WORKDIR $HOME

RUN pip install --user flask-restful==0.3.9 pandas==0.24.2 flask_cors==3.0.10

RUN mkdir models && \
    mkdir doc

ENV PYTHONPATH $PYTHONPATH:$HOME

CMD python restapi.py && bash

EXPOSE 5000
