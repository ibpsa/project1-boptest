FROM --platform=linux/x86_64 ubuntu:20.04

# Install required packages
RUN 	apt-get update && \
    	apt-get install -y \
    	wget \
    	libgfortran4

# Install commands for Spawn
ENV SPAWN_VERSION=0.3.0-8d93151657
RUN wget https://spawn.s3.amazonaws.com/custom/Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && tar -xzf Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && ln -s /Spawn-$SPAWN_VERSION-Linux/bin/spawn-$SPAWN_VERSION /usr/local/bin/

# Create new user
RUN 	useradd -ms /bin/bash user
USER user
ENV 	HOME /home/user

# Download and install miniconda and pyfmi
RUN 	cd $HOME && \
	wget https://repo.anaconda.com/miniconda/Miniconda3-py310_24.3.0-0-Linux-x86_64.sh -O $HOME/miniconda.sh && \
	/bin/bash $HOME/miniconda.sh -b -p $HOME/miniconda && \
	. miniconda/bin/activate && \
	conda update -n base -c defaults conda && \
	conda create --name pyfmi3 python=3.10 -y && \
	conda activate pyfmi3 && \
	conda install -c conda-forge pyfmi=2.12 -y && \
	pip install ptvsd==4.3.2 flask-restful==0.3.9 werkzeug==2.2.3 && \
	conda install pandas==1.5.3 flask_cors==3.0.10 matplotlib==3.7.1 requests==2.28.1 scipy==1.13.0

WORKDIR $HOME

RUN mkdir models && \
    mkdir doc

ENV PYTHONPATH $PYTHONPATH:$HOME
ENV BOPTEST_DASHBOARD_SERVER https://dashboard.boptest.net/

CMD . miniconda/bin/activate && conda activate pyfmi3 && python restapi.py && bash

EXPOSE 5000
