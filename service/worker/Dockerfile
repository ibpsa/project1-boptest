FROM ubuntu:20.04

USER root
ENV HOME /home/boptest

WORKDIR /

RUN apt-get update -y && apt-get install -y \
    ca-certificates wget curl libglu1 libgfortran4 libjpeg8 libfreetype6 libxi6 libdbus-glib-1-2 libfontconfig1 libsm6 gdebi-core \
    && apt-get install -y git

# Install commands for Spawn
ENV SPAWN_VERSION=0.3.0-8d93151657
RUN wget https://spawn.s3.amazonaws.com/custom/Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && tar -xzf Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && ln -s /Spawn-$SPAWN_VERSION-Linux/bin/spawn-$SPAWN_VERSION /usr/local/bin/

COPY worker/requirements/production.txt /boptest/

# Download and install miniconda, pyfmi, and remaining python requirements
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh -O /miniconda.sh \
	&& /bin/bash /miniconda.sh -b -p /miniconda \
	&& . miniconda/bin/activate \
	&& conda update -n base -c defaults conda \
	&& conda create --name pyfmi3 python=3.10 -y \
	&& conda activate pyfmi3 \
	&& conda install -c conda-forge pyfmi=2.11 -y \
	&& pip install -U pip setuptools \
  && python -m pip install --ignore-installed -r /boptest/production.txt \
  && conda install pandas==1.5.3

COPY worker /worker

# Organize boptest python source into a module
COPY boptest/testcase.py /boptest/lib/
COPY boptest/data /boptest/lib/data
COPY boptest/forecast /boptest/lib/forecast
COPY boptest/kpis /boptest/lib/kpis
COPY boptest/version.txt /boptest/
RUN touch /boptest/__init__.py /boptest/lib/__init__.py
# Boptest TestCase will look for version.txt in the current working directory
# which will be "/", therefore this link is required
RUN ln -sf /boptest/version.txt /version.txt

ENV PYTHONPATH $PYTHONPATH:/worker/jobs/:/boptest:/boptest/lib:/boptest/lib/kpis:/boptest/lib/forecast:/boptest/lib/data

CMD . miniconda/bin/activate && conda activate pyfmi3 && python -m worker
