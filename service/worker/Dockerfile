# The precompiled FMUs require the libgfortran.so.4 ABI from focal.
FROM --platform=linux/x86_64 ubuntu:20.04 AS fmu-compat

RUN apt-get update -y && apt-get install -y --no-install-recommends libgfortran4

FROM --platform=linux/x86_64 ubuntu:22.04

USER root
ENV HOME=/home/boptest

WORKDIR /

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates wget curl libglu1 libgfortran5 libjpeg8 libfreetype6 libxi6 libdbus-glib-1-2 libfontconfig1 libsm6 gdebi-core git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=fmu-compat /usr/lib/x86_64-linux-gnu/libgfortran.so.4* /usr/lib/x86_64-linux-gnu/

# Install commands for Spawn
ENV SPAWN_VERSION=light-0.4.3-7048a72798
RUN wget https://spawn.s3.amazonaws.com/builds/Spawn-$SPAWN_VERSION-Linux.tar.gz \
    && tar -xzf Spawn-$SPAWN_VERSION-Linux.tar.gz
ENV PATH=${PATH}:/Spawn-$SPAWN_VERSION-Linux/bin


COPY service/worker/requirements/production.txt /boptest/

# Download and install miniconda, pyfmi, and remaining python requirements
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py311_24.7.1-0-Linux-x86_64.sh -O /miniconda.sh \
	&& /bin/bash /miniconda.sh -b -p /miniconda \
	&& . miniconda/bin/activate \
	&& conda update -n base -c defaults conda \
	&& conda create --name pyfmi3 python=3.11 -y \
	&& conda activate pyfmi3 \
	&& conda install -c conda-forge pyfmi=2.14 -y \
	&& pip install -U pip setuptools \
  && python -m pip install -r /boptest/production.txt

COPY service/worker /worker

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

ENV PYTHONPATH=/worker/jobs/:/boptest:/boptest/lib:/boptest/lib/kpis:/boptest/lib/forecast:/boptest/lib/data

CMD ["/bin/bash", "-lc", ". /miniconda/etc/profile.d/conda.sh && conda activate pyfmi3 && exec python -m worker"]
