FROM ubuntu:20.04

# Install required packages
RUN 	apt-get update && \
    	apt-get install -y \
    	wget \
     libgfortran4

# Create new user
RUN 	useradd -ms /bin/bash user
USER user
ENV 	HOME /home/user

# Download and install miniconda and pyfmi
RUN 	cd $HOME && \
	wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh -O $HOME/miniconda.sh && \
	/bin/bash $HOME/miniconda.sh -b -p $HOME/miniconda && \
	. miniconda/bin/activate && \
	conda update -n base -c defaults conda && \
	conda create --name pyfmi3 python=3.8 -y && \
	conda activate pyfmi3 && \
	conda install -c conda-forge/label/cf202003 pyfmi -y && \
	conda install -c conda-forge/label/cf202003 flask-restful && \
	conda install pandas=1.3.4 flask_cors=3.0.10 matplotlib=3.5.1

WORKDIR $HOME

RUN mkdir models && \
    mkdir doc

ENV PYTHONPATH $PYTHONPATH:$HOME

CMD . miniconda/bin/activate && conda activate pyfmi3 && python restapi.py && bash

EXPOSE 5000
