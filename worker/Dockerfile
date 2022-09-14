FROM michaelwetter/ubuntu-1804_jmodelica_trunk

USER root
ENV HOME /home/boptest

WORKDIR /

RUN apt-get update -y && apt-get install -y \
    ca-certificates curl libglu1 libjpeg8 libfreetype6 libxi6 libdbus-glib-1-2 libfontconfig1 libsm6 gdebi-core python3.5 python3-pip \
    && apt-get install -y git

# Install commands for Spawn
ENV SPAWN_VERSION=0.3.0-8d93151657
RUN wget https://spawn.s3.amazonaws.com/custom/Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && tar -xzf Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && ln -s /Spawn-$SPAWN_VERSION-Linux/bin/spawn-$SPAWN_VERSION /usr/local/bin/

RUN curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py \
  && python3 get-pip.py

COPY worker/requirements/production.txt /boptest/
RUN  python3 -m pip install --ignore-installed -r /boptest/production.txt
RUN  python -m pip install --ignore-installed -r /boptest/production.txt

COPY worker /worker

# Organize boptest python source into a module
COPY testcase.py /boptest/lib/
COPY data /boptest/lib/data
COPY forecast /boptest/lib/forecast
COPY kpis /boptest/lib/kpis
COPY version.txt /boptest/
RUN touch /boptest/__init__.py /boptest/lib/__init__.py
# Boptest TestCase will look for version.txt in the current working directory
# which will be "/", therefore this link is required
RUN ln -sf /boptest/version.txt /version.txt

ENV ROOT_DIR /usr/local
ENV JMODELICA_HOME $ROOT_DIR/JModelica
ENV IPOPT_HOME $ROOT_DIR/Ipopt-3.12.4
ENV SUNDIALS_HOME $JMODELICA_HOME/ThirdParty/Sundials
ENV SEPARATE_PROCESS_JVM /usr/lib/jvm/java-8-openjdk-amd64/
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PYTHONPATH $PYTHONPATH:$JMODELICA_HOME/Python:$JMODELICA_HOME/Python/pymodelica:/worker/jobs/:/

RUN sed -i "350 i \\\n        if isinstance(self.model, fmi.FMUModelME2):\n            self.model.event_update()" $JMODELICA_HOME/Python/pyfmi/fmi_algorithm_drivers.py

CMD [ "python3", "-m", "worker" ]
