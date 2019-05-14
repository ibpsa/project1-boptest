'''
Created on May 1, 2019

@author: Javier Arroyo

This module contains the BOPTEST_compiler class. This class compiles 
models to be compliant with BOPTEST. For that, a Docker image is 
built that contains JModelica. The main difference with a BOPTEST 
test case image is that extra Modelica libraries are imported to 
include the Modelica model dependencies. 

'''

import os
import platform
import shutil
import subprocess

class BOPTEST_compiler(object):
    '''Class to compile Modelica models into a Docker container in 
    order to get an FMU compliant with BOPTEST. The functionality is
    independent of the host OS as it uses the subprocess package to 
    run shell commands from Python. These commands open a Docker 
    container where the model is compiled and copy the resulting 
    FMU back to the host.
    
    DOCKER_USER and DOCKER_PASSWORD need to be set as environmental 
    variables to enable login to the Docker Hub.
    
    There are two main methods in this class: `create_docker_compiler`
    and `compile` the former has to be called first to create and 
    push the Docker compiler to the Docker Hub for a test case. 
    Once the Docker image is created this method has not to be used
    anymore unless changes to the Modelica libraries are to be 
    included. 
    
    Once that is done,`compile` will use that Docker image to compile
    the model. Any change within the `models` folder of the test
    case will be reflected in each compilation. 
    
    '''
    
    def __init__(self):
        '''Define the Docker commands and login to Docker Hub
        
        '''
        
        # Define variables and commands for the Docker
        TESTCASE=os.environ['TESTCASE']
        DOCKER_USER=os.environ['DOCKER_USER']
        DOCKER_PASSWORD=os.environ['DOCKER_PASSWORD']
        
        # Container name
        CNT_NAME='boptest_compiler_'+TESTCASE
        
        # Image name
        IMG_NAME=DOCKER_USER+'/'+CNT_NAME
        
        # Define Docker commands
        self.login_cmd = 'docker login -u {DOCKER_USER} -p {DOCKER_PASSWORD}'.format(DOCKER_USER=DOCKER_USER, 
                                                                                     DOCKER_PASSWORD=DOCKER_PASSWORD)
                
        self.build_cmd = 'cd ../ && \
        docker build \
        -f compilation/Dockerfile.compile \
        --build-arg testcase={TESTCASE} \
        --no-cache \
        --rm \
        -t {IMG_NAME} .'.format(TESTCASE=TESTCASE,
                                IMG_NAME=IMG_NAME)
        
        self.push_cmd = 'docker push {IMG_NAME}'.format(IMG_NAME=IMG_NAME)
        
        self.pull_cmd = 'docker pull {IMG_NAME}'.format(IMG_NAME=IMG_NAME)
        
        self.copy_h2d_cmd = 'cd ../ && docker cp {TESTCASE}/models {CNT_NAME}:home/developer'.format(TESTCASE=TESTCASE,
                                                                                                     CNT_NAME=CNT_NAME)
        
        self.run_cmd = '''docker run \
        --name {CNT_NAME} \
        -i \
        -p 127.0.0.1:5000:5000 \
        --rm \
        --detach=True \
        {IMG_NAME}'''.format(CNT_NAME=CNT_NAME,
                             IMG_NAME=IMG_NAME)
        
        self.compile_cmd = '''docker exec {CNT_NAME} \
        /bin/bash -c \
        "cd models && \
        python compile_fmu.py"'''.format(CNT_NAME=CNT_NAME)
                
        self.copy_d2h_cmd = '''cd ../ && \
        docker cp {CNT_NAME}:home/developer/models/wrapped.fmu {TESTCASE}/models/wrapped.fmu && \
        docker cp {CNT_NAME}:home/developer/models/wrapped.mo {TESTCASE}/models/wrapped.mo'''.format(CNT_NAME=CNT_NAME,
                                                                                                     TESTCASE=TESTCASE)
        
        self.stop_cmd = 'docker stop {CNT_NAME}'.format(CNT_NAME=CNT_NAME)
        
        # Login to Docker Hub
        subprocess.call(self.login_cmd, shell=True)

    def compile(self):
        '''This method does the following:
        
        1. Pulls the test case Docker compiler image
        2. Runs the Docker compiler
        3. Copies the test case `models` folder into the container  
        4. Compiles the model in the Docker container
        5. Copies the wrapped.fmu and wrapped.mo within the
           testcase# folder of the host machine
        6. Stops and removes the container
           
        '''
            
        # Pull Docker compiler image from Docker Hub 
        subprocess.call(self.pull_cmd, shell=True)
        
        # Deploy container
        subprocess.call(self.run_cmd, shell=True)
        
        # Copy the models folder from the host to the Docker
        subprocess.call(self.copy_h2d_cmd, shell=True)
                
        # Compile
        subprocess.call(self.compile_cmd, shell=True)
        
        # Copy from docker to host
        subprocess.call(self.copy_d2h_cmd, shell=True)
        
        # Stop container
        subprocess.call(self.stop_cmd, shell=True)
        
    def create_docker_compiler(self, modelica_libs=[]):
        '''This method creates a docker compiler with the Modelica 
        libraries passed through the modelica_libs argument. 
        The method goes through the following steps:
        
        1. Copies the required Modelica libraries within the compilation folder
        2. Edits the Dockerfile to copy and append the Modelica libraries
           to the MODELICAPATH of the Docker
        3. Builds the Docker compiler image 
        4. Removes the copied libraries from the compilation folder
        5. Reverts edits in Dockerfile to leave the original version
        6. Pushes the Docker image to Docker Hub
        
        Parameters
        ----------
        modelica_libs: list
            list with the absolute paths to the Modelica libraries
            required to compile the model
            
        Notes
        -----
        
        Docker mounting is not used because sharing drives leads 
        to multiple errors, namely:
            - Paths with any space are not allowed
            - Docker -> Settings -> shared-drives the shared checkbox
              is never checked. 
        See:
            - https://github.com/OpenDroneMap/ODM/issues/591
            - https://github.com/docker/for-win/issues/690
            
        The libraries have to be copied to the compilation folder because
        in a Dockerfile the absolute path refers to an absolute path 
        within the build context, not an absolute path on the host. So all 
        the resources must be copied into the directory where the Docker 
        is built and then provide the path of those resources within the 
        Dockerfile before building the image.
        
        '''
        
        # Find separator for environmental variables depending on OS
        if platform.system() == 'Linux':
            sep = ':'
        else:
            sep = ';'
        
        # Try to find the IBPSA library from the libraries provided
        IBPSA_in_modelica_libs = False
        for lib in modelica_libs:
            if 'IBPSA' in lib:
                IBPSA_in_modelica_libs = True
                break
        
        # If no Modelica library provided try to find it in MODELICAPATH
        if not IBPSA_in_modelica_libs:
            for p in os.environ['MODELICAPATH'].split(sep):
                if os.path.isdir(os.path.join(p,'IBPSA')):
                    modelica_libs.append(p)
                    IBPSA_in_modelica_libs = True
                    break
                
        # If IBPSA library is not found raise an error
        if not IBPSA_in_modelica_libs:
            raise ValueError('Provide a path to the IBPSA library or point '\
                             'to the IBPSA library in your MODELICAPATH')   
        
        # Copy Modelica libraries to compilation folder
        for lib in modelica_libs:
            shutil.copytree(lib, lib.split(os.sep)[-1])
        
        # Edit the Dockerfile to copy the Modelica folders within the Docker
        str_old = 'RUN mkdir data'
        str_new = str_old
        
        for lib in modelica_libs:
            str_new += '\nRUN mkdir {0}'.format(lib.split(os.sep)[-1])
            str_new += '\nCOPY compilation/{0} ./{0}'.format(lib.split(os.sep)[-1])
            str_new += '\nENV MODELICAPATH $MODELICAPATH:$HOME/{0}'.format(lib.split(os.sep)[-1])
        
        with open('Dockerfile.compile') as f:
            newText=f.read().replace(str_old, str_new)
        
        with open('Dockerfile.compile', "w") as f:
            f.write(newText)
        
        # Build the docker compiler image
        subprocess.call(self.build_cmd, shell=True)
        
        # Revert changes in Dockerfile
        with open('Dockerfile.compile') as f:
            newText=f.read().replace(str_new, str_old)
            
        with open('Dockerfile.compile', "w") as f:
            f.write(newText)
            
        # Remove the copied libraries
        for lib in modelica_libs:
            shutil.rmtree(lib.split(os.sep)[-1], ignore_errors=True)
                    
        # Push the docker image
        subprocess.call(self.push_cmd, shell=True)
        
if __name__ == '__main__':
    os.environ['TESTCASE'] = 'testcase1'
    compiler = BOPTEST_compiler()
    compiler.compile()
    