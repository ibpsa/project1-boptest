FROM michaelwetter/ubuntu-1804_jmodelica_trunk

USER root
ENV HOME /home/boptest

WORKDIR /

RUN apt-get update -y && apt-get install -y \
    ca-certificates curl libglu1 libjpeg8 libfreetype6 libxi6 libdbus-glib-1-2 libfontconfig1 libsm6 gdebi-core python3.5 python3-pip \
    && apt-get install -y git

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3 get-pip.py

COPY worker/requirements/production.txt /boptest/
RUN  python3 -m pip install --ignore-installed -r /boptest/production.txt
RUN  python -m pip install --ignore-installed -r /boptest/production.txt

COPY worker /boptest/
# Perhaps it would be better to move these files in the <project-root>/worker directory
# however his copy results in a ligher touch / smaller merge, with less
# intrusion on the existing project layout
COPY testcase.py boptest/lib/
COPY data boptest/lib/data
COPY forecast boptest/lib/forecast
COPY kpis boptest/lib/kpis

ENV ROOT_DIR /usr/local
ENV JMODELICA_HOME $ROOT_DIR/JModelica
ENV IPOPT_HOME $ROOT_DIR/Ipopt-3.12.4
ENV SUNDIALS_HOME $JMODELICA_HOME/ThirdParty/Sundials
ENV SEPARATE_PROCESS_JVM /usr/lib/jvm/java-8-openjdk-amd64/
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PYTHONPATH $PYTHONPATH:$JMODELICA_HOME/Python:$JMODELICA_HOME/Python/pymodelica

RUN sed -i "350 i \\\n        if isinstance(self.model, fmi.FMUModelME2):\n            self.model.event_update()" $JMODELICA_HOME/Python/pyfmi/fmi_algorithm_drivers.py

CMD [ "python3", "-m", "boptest" ]
