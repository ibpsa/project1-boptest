FROM ubuntu:18.04

ARG testcase

RUN apt-get update && \
    apt-get install -y \
	python3-pip \
	firefox \
	wget

RUN pip3 install splinter urllib3 pandas selenium

ENV PATH $PATH:/home

WORKDIR /home

RUN cd /home && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz && \
	tar -xvzf geckodriver*  && \
	rm geckodriver-*

COPY wrapper.py ./

COPY ${testcase}.html ./
