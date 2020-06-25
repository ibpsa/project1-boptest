# -*- coding: utf-8 -*-
"""
Implements the parsing and code generation for signal exchange blocks.

The steps are:
1) Compile Modelica code into fmu
2) Use signal exchange block id parameters to find block instance paths and 
read any associated signals for KPIs, units, min/max, and descriptions.
3) Write Modelica wrapper around instantiated model and associated KPI list.
4) Export as wrapper FMU and save KPI json.
5) Save test case data within wrapper FMU.

"""

from pyfmi import load_fmu
import os
import shutil
import json
from data.data_manager import Data_Manager
import warnings

def parse_instances(model_path, file_name, resources=None):
    '''Parse the signal exchange block class instances using fmu xml.

    Parameters
    ----------
    model_path : str
        Path to modelica model
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica.
    resources : str, optional
        Directory path for resources needed to compile model, such as weather file.
        Default is None.    

    Returns
    -------
    instances : dict
        Dictionary of overwrite and read block class instance lists.
        {'Overwrite': {input_name : {Unit : unit_name, Description : description, Minimum : min, Maximum : max}}, 
         'Read': {output_name : {Unit : unit_name, Description : description, Minimum : min, Maximum : max}}}
    signals : dict
        {'signal_type' : [output_name]}

    '''

    # Compile fmu
    fmu_path = _compile_fmu(model_path, file_name, resources=resources)
    # Load fmu
    fmu = load_fmu(fmu_path)
    # Check version
    if fmu.get_version() != '2.0':
        raise ValueError('FMU version must be 2.0')
    # Get all parameters
    allvars = []
    for key in fmu.get_model_variables(variability = 0).keys():
        allvars.append(key)
    for key in fmu.get_model_variables(variability = 1).keys():
        allvars.append(key)
    # Initialize dictionaries
    instances = {'Overwrite':dict(), 'Read':dict()}
    signals = {}
    # Find instances of 'Overwrite' or 'Read'
    for var in allvars:
        # Get instance name
        instance = '.'.join(var.split('.')[:-1])
        # Overwrite
        if 'boptestOverwrite' in var:
            label = 'Overwrite'
            unit = fmu.get_variable_unit(instance+'.u')
            description = fmu.get(instance+'.description')[0]
            mini = fmu.get_variable_min(instance+'.u')
            maxi = fmu.get_variable_max(instance+'.u')
        # Read
        elif 'boptestRead' in var:
            label = 'Read'
            unit = fmu.get_variable_unit(instance+'.y')
            description = fmu.get(instance+'.description')[0]
            mini = None
            maxi = None
        # KPI
        elif 'KPIs' in var:
            label = 'kpi'
        else:
            continue
        # Save instance
        if label != 'kpi':
            instances[label][instance] = {'Unit' : unit}
            instances[label][instance]['Description'] = description
            instances[label][instance]['Minimum'] = mini
            instances[label][instance]['Maximum'] = maxi
        else:
            signal_type = fmu.get_variable_declared_type(var).items[fmu.get(var)[0]][0]
            # Split certain signal types for multi-zone
            if signal_type in ['AirZoneTemperature',
                               'RadiativeZoneTemperature',
                               'OperativeZoneTemperature',
                               'RelativeHumidity',
                               'CO2Concentration']:
                signal_type = '{0}[{1}]'.format(signal_type, fmu.get(instance+'.zone')[0])
            if signal_type in signals:
                signals[signal_type].append(_make_var_name(instance,style='output'))
            else:
                signals[signal_type] = [_make_var_name(instance,style='output')]
                
    # Clean up
    os.remove(fmu_path)
    os.remove(fmu_path.replace('.fmu', '_log.txt'))

    return instances, signals

def write_wrapper(model_path, file_name, instances, resources=None):
    '''Write the wrapper modelica model and export as fmu

    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica.
    instances : dict
        Dictionary of overwrite and read block class instance lists.
        {'Overwrite': [str], 'Read': [str]}
    resources : str, optional
        Directory path for resources needed to compile model, such as weather file.
        Default is None.

    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    wrapped_path : str or None
        Path to the wrapped modelica model if instances of signale exchange.
        Otherwise, None

    '''

    # Check for instances of Overwrite and/or Read blocks
    len_write_blocks = len(instances['Overwrite'])
    len_read_blocks = len(instances['Read'])
    # If there are, write and export wrapper model
    if (len_write_blocks + len_read_blocks):
        # Define wrapper modelica file path
        wrapped_path = 'wrapped.mo'
        # Open file
        with open(wrapped_path, 'w') as f:
            # Start file
            f.write('model wrapped "Wrapped model"\n')
            # Add inputs for every overwrite block
            f.write('\t// Input overwrite\n')
            input_signals_w_info = dict()
            input_signals_wo_info = dict()
            input_activate_w_info = dict()
            input_activate_wo_info = dict()
            for block in instances['Overwrite'].keys():
                # Add to signal input list with and without units
                input_signals_w_info[block] = _make_var_name(block,style='input_signal',description=instances['Overwrite'][block]['Description'],attribute='(unit="{0}", min={1}, max={2})'.format(instances['Overwrite'][block]['Unit'], instances['Overwrite'][block]['Minimum'], instances['Overwrite'][block]['Maximum']))
                input_signals_wo_info[block] = _make_var_name(block,style='input_signal')
                # Add to signal activate list
                input_activate_w_info[block] = _make_var_name(block,style='input_activate',description='Activation for {0}'.format(instances['Overwrite'][block]['Description']))
                input_activate_wo_info[block] = _make_var_name(block,style='input_activate')
                # Instantiate input signal
                f.write('\tModelica.Blocks.Interfaces.RealInput {0};\n'.format(input_signals_w_info[block], block))
                # Instantiate input activation
                f.write('\tModelica.Blocks.Interfaces.BooleanInput {0};\n'.format(input_activate_w_info[block], block))
            # Add outputs for every read block
            f.write('\t// Out read\n')
            for block in instances['Read'].keys():
                # Instantiate input signal
                f.write('\tModelica.Blocks.Interfaces.RealOutput {0} = mod.{1}.y "{2}";\n'.format(_make_var_name(block,style='output',attribute='(unit="{0}")'.format(instances['Read'][block]['Unit'])), block, instances['Read'][block]['Description']))
            # Add original model
            f.write('\t// Original model\n')
            f.write('\t{0} mod(\n'.format(model_path))
            # Connect inputs to original model overwrite and activate signals
            if len_write_blocks:
                for i,block in enumerate(instances['Overwrite']):
                    f.write('\t\t{0}(uExt(y={1}),activate(y={2}))'.format(block, input_signals_wo_info[block], input_activate_wo_info[block]))
                    if i == len(instances['Overwrite'])-1:
                        f.write(') "Original model with overwrites";\n')
                    else:
                        f.write(',\n')
            else:
                f.write(') "Original model without overwrites";\n')
            # End file
            f.write('end wrapped;')
        # Export as fmu
        fmu_path = _compile_fmu('wrapped', [wrapped_path]+file_name, resources=resources)
    # If there are not, write and export wrapper model
    else:
        # Warn user
        warnings.warn('No signal exchange block instances found in model.  Exporting model as is.')
        # Compile fmu
        fmu_path = _compile_fmu(model_path, file_name, resources=resources)
        wrapped_path = None

    return fmu_path, wrapped_path

def export_fmu(model_path, file_name, resources=None):
    '''Parse signal exchange blocks and export boptest fmu and kpi json.

    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica.
    resources : str, optional
        Directory path for resources needed to compile model, such as weather file.
        Default is None.

    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    kpi_path : str
        Path to kpi json

    '''

    # Get signal exchange instances and kpi signals
    instances, signals = parse_instances(model_path, file_name, resources=resources)
    # Write wrapper and export as fmu
    fmu_path, _ = write_wrapper(model_path, file_name, instances, resources=resources)
    # Write kpi json
    kpi_path = os.path.join(os.getcwd(), 'kpis.json')
    with open(kpi_path, 'w') as f:
        json.dump(signals, f)
    # Generate test case data
    man = Data_Manager()
    man.save_data_and_kpisjson(fmu_path=fmu_path)
    
    return fmu_path, kpi_path

def _make_var_name(block, style, description='', attribute=''):
    '''Make a variable name from block instance name.
    
    Parameters
    ----------
    block : str
        Instance name of block
    style : str
        Style of variable to be made.
        "input_signal"|"input_activate"|"output"
    description : str, optional
        Description of variable to be added as comment
    attribute : str, optional
        Attribute string of variable.
        Default is empty.
        
    Returns
    -------
    var_name : str
        Variable name associated with block
        
    '''

    # General modification
    name = block.replace('.', '_')
    # Handle empty descriptions
    if description == '':
        description = ''
    else:
        description = ' "{0}"'.format(description)
        
    # Specific modification
    if style == 'input_signal':
        var_name = '{0}_u{1}{2}'.format(name,attribute, description)
    elif style == 'input_activate':
        var_name = '{0}_activate{1}'.format(name, description)
    elif style == 'output':
        var_name = '{0}_y{1}{2}'.format(name,attribute, description)
    else:
        raise ValueError('Style {0} unknown.'.format(style))

    return var_name

def _compile_fmu(model_path, file_name, target='cs', resources=None):
    '''Compiles an fmu using the JModelica docker container.
    
    Required libraries must be on MODELICAPATH or specified by .mo files in file_name.
    
    1. Starts docker container
    2. Creates new "compile" directory in docker container and adds to MODELICAPATH
    3. Copies directories on MODELICAPATH into "compile"
    4. Copies directories in file_name and resources into "compile"
    5. Copies "_compile_fmu.py" into "compile"
    6. Runs "_compile_fmu.py" to compile the FMU
    7. Copies fmu back to current directory
    8. Closes docker container
    
    Parameters
    ----------
    model_path : str
        Path to modelica model.
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica
    target : str, optional
        'me' for model exchange fmu, 'cs' for co-simulation fmu with CVode solver.
        Default is 'cs'.
    resources : str, optional
        Directory path for resources needed to compile model, such as weather file.
        Default is None.
        
    Returns
    -------
    fmu_path : str
        Path to the modelica model fmu.
    
    '''

    # Docker setup
    image_name = 'michaelwetter/ubuntu-1804_jmodelica_trunk'
    container_name = 'jm'
    compile_dir = '/home/developer/compile'
    run_options = '--name {0} --detach=true --user $UID --rm -it {1}'.format(container_name, image_name)
    # Start docker container
    os.system('docker run {0}'.format(run_options))
    # Create new "compile" directory
    os.system('docker exec {0} /bin/bash -c "mkdir {1} && exit"'.format(container_name, compile_dir))
    # Copy MODELICAPATH directories into "compile" and add to MODELICAPATH command
    modelicapath_docker = ''
    docker_lib_paths = []
    if os.environ is not None:
        if 'MODELICAPATH' in os.environ:
            MODELICAPATH = os.environ['MODELICAPATH'].split(':')
            # Add User MODELICAPATH first
            for path in MODELICAPATH:
                os.system('docker cp {0} {1}:{2}'.format(path, container_name, compile_dir))
                docker_lib_path = '{0}/{1}'.format(compile_dir, os.path.split(path)[-1])
                docker_lib_paths.append(docker_lib_path)
                modelicapath_docker = '{0}:{1}'.format(modelicapath_docker,docker_lib_path)
    # Add JModelica MODELICAPATH second
    for path in ['/usr/local/JModelica/ThirdParty/MSL',
                 '/usr/local/JModelica/ThirdParty/MSL/ModelicaServices']:
        modelicapath_docker = '{0}:{1}'.format(modelicapath_docker,path)
    modelicapath_docker = modelicapath_docker[1:]
    # Copy "file_name" directories and libraries into "compile" and add to file_path_str and copy resources if there are
    docker_file_path_str = ''
    for f in file_name:
        if 'package.mo' in f:
            lib_name = os.path.split(f)[0]
            os.system('docker cp {0} {1}:{2}'.format(lib_name, container_name, compile_dir))
            docker_lib_path = '{0}/{1}'.format(compile_dir, lib_name)
            docker_lib_paths.append(docker_lib_path)
            docker_file_path = '{0}/{1}'.format(compile_dir, f)
        else:
            os.system('docker cp {0} {1}:{2}'.format(f, container_name, compile_dir))
            f_name = os.path.split(f)[-1]
            docker_file_path = '{0}/{1}'.format(compile_dir, f_name)
        docker_file_path_str = '{0} {1}'.format(docker_file_path_str,docker_file_path)
    docker_file_path_str = docker_file_path_str[1:]
    if resources:
        os.system('docker cp {0} {1}:{2}'.format(resources, container_name, compile_dir))
    # Copy "_compile_fmu.py" into "compile"
    PYTHONPATH = os.environ['PYTHONPATH'].split(':')
    for path in PYTHONPATH:
        if 'project1-boptest' in path:
            boptest_path = path
            continue
    f = os.path.join(boptest_path,'parsing', '_compile_fmu.py')
    os.system('docker cp {0} {1}:{2}'.format(f, container_name, compile_dir))
    # Run "_compile_fmu.py" in container
    os.system('docker exec {0} /bin/bash -c "cd {1} && export MODELICAPATH={2} && /usr/local/JModelica/bin/jm_ipython.sh _compile_fmu.py {3} {4} && exit"'.format(container_name, compile_dir, modelicapath_docker, model_path, docker_file_path_str))
    # Remove libraries and files from container
    for docker_lib_path in docker_lib_paths:
        os.system('docker exec {0} /bin/bash -c "rm -r {1} && exit"'.format(container_name,docker_lib_path))
    os.system('docker exec {0} /bin/bash -c "rm {1}/{2} && exit"'.format(container_name,compile_dir,'_compile_fmu.py'))
    # Copy fmu compilation directory back to current directory
    os.system('docker cp {0}:{1}/ ./'.format(container_name, compile_dir))
    # Stop docker container
    os.system('docker stop {0}'.format(container_name))
    # Move fmu and remove compile directory
    for _,_,files in os.walk('compile'):
        for f in files:
            if f.endswith('fmu'):
                fmu_path = f
                os.rename('compile/{0}'.format(f), f)
    shutil.rmtree('compile')
    
    return fmu_path

if __name__ == '__main__':
    # Define model
    model_path = 'SimpleRC'
    mo_path = 'SimpleRC.mo'
    # Parse and export
    fmu_path, kpi_path = export_fmu(model_path, [mo_path])
    # Print information
    print('Exported FMU path is: {0}'.format(fmu_path))
    print('KPI json path is: {0}'.format(kpi_path))
