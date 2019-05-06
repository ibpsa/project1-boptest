'''
Created on May 1, 2019

@author: Javier Arroyo

This module contains the BOPTEST_compiler class. This class compiles 
models to be compliant with BOPTEST. For that,
a Docker container is deployed as the one that used for BOPTEST test
cases. The main difference with a BOPTEST testcase cpmtaomer is that 
extra Modelica libraries are imported to include the Modelica model
dependencies. 

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
    
    '''
    
    def __init__(self):
        '''Constructor
        
        '''
        # Define variables and commands for the Docker
        TESTCASE=os.environ['TESTCASE']
        IMG_NAME='boptest_compiler_'+TESTCASE
        
        COMMAND_RUN = '''docker run \
        --name {IMG_NAME} \
        -i \
        -p 127.0.0.1:5000:5000'''.format(IMG_NAME=IMG_NAME)
        
        self.build_cmd = 'cd ../ && docker build -f compilation/Dockerfile.compile --build-arg testcase={TESTCASE} --no-cache --rm -t {IMG_NAME} .'.format(TESTCASE=TESTCASE,
                                                                                                                                                           IMG_NAME=IMG_NAME)
            
        self.compile_cmd = '{COMMAND_RUN} --detach=false {IMG_NAME} /bin/bash -c "cd models && python compile_fmu.py && bash"'.format(COMMAND_RUN=COMMAND_RUN,
                                                                                                                                      IMG_NAME=IMG_NAME,
                                                                                                                                      TESTCASE=TESTCASE)
        
        self.copy_cmd = '''cd ../ && docker cp {IMG_NAME}:home/developer/models/wrapped.fmu {TESTCASE}/models/wrapped.fmu && docker cp {IMG_NAME}:home/developer/models/wrapped.mo {TESTCASE}/models/wrapped.mo'''.format(IMG_NAME=IMG_NAME,
                                                                                                                                                                                                                          TESTCASE=TESTCASE)
        
        self.stop_cmd = 'docker stop {IMG_NAME}'.format(IMG_NAME=IMG_NAME)
        self.remove_container_cmd = 'docker rm {IMG_NAME}'.format(IMG_NAME=IMG_NAME)
        self.remove_image_cmd = 'docker rmi {IMG_NAME}'.format(IMG_NAME=IMG_NAME)

    def compile(self, modelica_libs = []):
        '''
        
        This method does the following:
        
        1. Copies the required Modelica libraries within the compilation folder
        2. Edits the Dockerfile to copy and append the Modelica libraries
           to the MODELICAPATH of the Docker
        3. Builds the Docker compiler image by calling `make build`
        4. Runs the Docker compiler image by calling `make run`
        5. Compiles the model in the Docker compiler by calling `make compile`
           This call will also copy the wrapped.fmu and wrapped.mo within the
           testcase# folder of the host
        7. Removes the copied libraries from the compilation folder
        8. Revert edits in Dockerfile to leave the original version
        
        The libraries have to be copied to the compilation folder because
        in a Dockerfile the absolute path refers to an absolute path 
        within the build context, not an absolute path on the host. So all 
        the resources must be copied into the directory where the Docker 
        is built and then provide the path of those resources within the 
        Dockerfile before building the image.
        
        Parameters
        ----------
        modelica_libs: list
            list with the absolute paths to the Modelica libraries
            required to compile the model
        
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
        
        # Copy modelica libraries to compilation folder
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
        
        # Build the compiler container
        subprocess.call(self.build_cmd, shell=True)
        
        # Revert changes in Dockerfile
        with open('Dockerfile.compile') as f:
            newText=f.read().replace(str_new, str_old)
            
        with open('Dockerfile.compile', "w") as f:
            f.write(newText)
            
        # Remove the copied libraries
        for lib in modelica_libs:
            shutil.rmtree(lib.split(os.sep)[-1], ignore_errors=True)
        
        # Compile
        subprocess.call(self.compile_cmd, shell=True)
        
        # Copy
        subprocess.call(self.copy_cmd, shell=True)
        
        # Stop
        subprocess.call(self.stop_cmd, shell=True)
        
        # Remove container
        subprocess.call(self.remove_container_cmd, shell=True)
        
        # Remove image
        subprocess.call(self.remove_image_cmd, shell=True)
        
        print 'Compilation finished'
    
    
if __name__ == '__main__':
    os.environ['TESTCASE'] = 'testcase1'
    compiler = BOPTEST_compiler()
    compiler.compile()
    