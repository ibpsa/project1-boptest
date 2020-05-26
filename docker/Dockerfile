FROM ubuntu:18.04

# Install required packages
RUN 	apt-get update && \
    	apt-get install -y \
    	wget

# Create new user
RUN     useradd -ms /bin/bash user
USER    user
ENV     HOME /home/user

# Download and install miniconda, pyfmi, and other python packages in boptest environment
RUN 	cd $HOME && \
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh && \
	/bin/bash $HOME/miniconda.sh -b -p $HOME/miniconda && \
	. miniconda/bin/activate && \
	conda update -n base -c defaults conda && \
	conda create --name boptest -y && \
	conda activate boptest && \
	conda install -c conda-forge pyfmi flask-restful -y && \
	conda install pandas matplotlib

# Set working directory to home
WORKDIR $HOME
