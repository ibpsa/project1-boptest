# Start with a base Ubuntu image
FROM ubuntu:20.04

# Avoid warnings while installing ubuntu
# debconf: unable to initialize frontend: Dialog
# debconf: (TERM is not set, so the dialog frontend is not usable.)
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install packages
RUN apt update && \
    apt install -y --no-install-recommends\
    git \
    python3.9 \
    python3-pip  \
    build-essential \
    ruby-dev \
    && \
    rm -rf /var/lib/apt/lists/*

# Install sphinx dependencies
RUN pip install \
    sphinx \
    sphinx_bootstrap_theme \
    sphinxcontrib-bibtex 

RUN gem install jekyll -v 4.1.0
RUN gem install bundler -v 2.1.4

# Add developer user with permissions in the working directory
ENV HOME /home
ENV WORKDIR /home

# Use the Gemfile and Gemfile.lock to install dependencies for Jekyll website
COPY web/Gemfile .
COPY web/Gemfile.lock .
RUN bundle install
