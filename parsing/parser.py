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
import subprocess
import os
import json
from data.data_manager import Data_Manager
import warnings
import time
import zipfile
import xml.etree.ElementTree as ET
import platform

if 'MODELICAPATH' in os.environ:
    modelicapath=os.environ['MODELICAPATH']
else:
    modelicapath=os.path.abspath('.')

def compile_fmu_dymola(model_path, algorithm='Cvode', tolerance=1e-6):
    '''Execute dymola process to compile FMU.

    model_path : str
        Path to modelica model
    algorithm : str, optional
        Specify the solver algorithm. For tool='Dymola' only. Options are 'Cvode', 'Dassl', 'Radau', 'Lsodar'.
        Default is 'Cvode'.
    tolerance : numeric, optional
        Specify the solver tolerance. For tool='Dymola' only.
        Default is 1e-6.

    '''

    # Check solver option is valid
    valid_algorithms =  ['Cvode', 'Dassl', 'Radau', 'Lsodar']
    if algorithm not in valid_algorithms:
        raise ValueError('Invalid algorithm "{0}" for tool Dymola.  Choose from {1}.'.format(algorithm, valid_algorithms))
    # Create expected fmu file name (observed rule of dymola)
    fmu_path = model_path.replace('_','_0').replace('.','_') + '.fmu'
    # Start by removing fmu if it exists already
    if os.path.exists(fmu_path):
        os.remove(fmu_path)
    with open('compile_fmu.mos', 'w') as f:
        f.write('Advanced.FMI.CopyExternalResources = true;\n')
        f.write('Advanced.FMI.AllowStringParametersForFMU = true;\n')
        f.write('OutputCPUtime = false;\n')
        f.write('Evaluate = true;\n')
        f.write('Advanced.OutputModelicaCode = true;\n')
        f.write('experiment(Algorithm="{0}",Tolerance={1});\n'.format(algorithm, tolerance))
        f.write('Advanced.FMI.UseExperimentSettings=true;\n')
        if platform.system() == 'Windows':
            f.write('Advanced.FMI.CrossExport=true;\n')
        f.write('translateModelFMU("{0}", false, "", "2", "csSolver", false, 0, fill("",0));\n'.format(model_path))
        f.write('exit();')
    process = subprocess.Popen(['dymola','compile_fmu.mos', '/nowindow'])
    while process.poll() == None:
        time.sleep(10)
        print('Waiting for Dymola to finish compiling {0}.  Checking again in 10 seconds...'.format(fmu_path))
    print('Dymola finished compiling {0}.'.format(fmu_path))

    return fmu_path

def get_parameter_dymola(scalar_variables, instance, parameter, type='String'):
    '''Parses the fmu model description xml to get the string parameter value.

    Parameters
    ----------
    scalar_variables : xml child iterations
        XML children "ScalarVariable".
    instance : str
        Parser instance.
    parameter : str
        Parameter of the parser instance to get value for.
    type : str
        Type of parameter defined by xml child.  e.g. "String" or "Enumeration"

    Returns
    -------
    value : parameter type
        Value of instance parameter.

    '''

    var = instance + '.' + parameter
    found = False
    # Look for variable in xml
    for svariable in scalar_variables:
        if svariable.get('name') == var:
            value = svariable.find(type).attrib['start']
            found = True
    # If not found, check in .mof
    if not found:
        value = None
        flag = False
        with open('dsmodel.mof', 'r') as f:
            for l in f:
                s = l.strip()
                if (var in s) or flag:
                    if type == 'String':
                        start = s.find('"')
                        if start < 0:
                            flag = True
                            continue
                        else:
                            end = s.find('"', start+1)
                            value = s[start+1:end]
                            flag = False
                            break
                    else:
                        raise ValueError('Looking in dmodel.mof for parameter values only supported for parameters of type String.')
        if not value:
            raise ValueError('Could not find variable in xml nor dsmodel.mof "{0}".'.format(var))

    return value

def get_signal_types_dymola(simple_types):
    '''Parses the fmu model description xml to get the KPI signal type enumerations.

    Parameters
    ----------
    simple_types : xml child iterations
        XML children "SimpleType".

    Returns
    -------
    signal_types : dict
        {int : str}.

    '''

    signal_types = dict()
    found = False
    for stype in simple_types:
        if 'SignalExchange.SignalTypes.SignalsForKPIs' in stype.get('name'):
            enumeration = stype.find('Enumeration')
            for item in enumeration.findall('Item'):
                signal_types[item.attrib['value']] = item.attrib['name']
            found = True
            break
    if not found:
        signal_types = None
        raise ValueError('Could not find signal types in xml.')

    return signal_types


def parse_instances(model_path, file_name, tool='JModelica', algorithm='Cvode', tolerance=1e-6):
    '''Parse the signal exchange block class instances using fmu xml.

    Parameters
    ----------
    model_path : str
        Path to modelica model
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica.
    tool : str, optional
        FMU compilation tool. "JModelica" or "OCT" or "Dymola" supported.
        Default is "JModelica".
   algorithm : str, optional
        Specify the solver algorithm. For tool='Dymola' only. Options are 'Cvode', 'Dassl', 'Radau', 'Lsodar'.
        Default is 'Cvode'.
    tolerance : numeric, optional
        Specify the solver tolerance. For tool='Dymola' only.
        Default is 1e-6.

    Returns
    -------
    instances : dict
        Dictionary of overwrite and read block class instance lists.
        {'Overwrite': {input_name : {Unit : unit_name, Description : description, Minimum : min, Maximum : max}},
         'Read': {output_name : {Unit : unit_name, Description : description, Minimum : min, Maximum : max}}}
    signals : dict
        {'signal_type' : [output_name]}

    '''

    # Check solver option is valid
    valid_algorithms =  ['Cvode', 'Dassl', 'Radau', 'Lsodar']
    if (algorithm not in valid_algorithms) and (tool=='Dymola'):
        raise ValueError('Invalid algorithm "{0}" for tool Dymola.  Choose from {1}.'.format(algorithm, valid_algorithms))
    # Compile fmu
    if tool == 'JModelica':
        from pymodelica import compile_fmu
        fmu_path = compile_fmu(model_path, file_name, jvm_args="-Xmx8g", target='cs')
    elif tool == 'OCT':
        from pymodelica import compile_fmu
        fmu_path = compile_fmu(model_path, file_name, modelicapath=modelicapath, jvm_args="-Xmx8g", target='cs')
    elif tool == 'Dymola':
        fmu_path = compile_fmu_dymola(model_path, algorithm=algorithm, tolerance=tolerance)
    else:
        raise ValueError('Tool {0} unknown.'.format(tool))
    # Load fmu
    fmu = load_fmu(fmu_path)
    # Check version
    if fmu.get_version() != '2.0':
        raise ValueError('FMU version must be 2.0')
    # Get all parameters
    allvars =   list(fmu.get_model_variables(variability = 0).keys()) + \
                list(fmu.get_model_variables(variability = 1).keys())
    # Initialize dictionaries
    instances = {'Overwrite':dict(), 'Read':dict()}
    signals = {}
    # Parse xml if using Dymola exported FMU
    if tool == 'Dymola':
        z_fmu = zipfile.ZipFile(fmu_path, 'r')
        xml = ET.fromstring(z_fmu.read('modelDescription.xml'))
        z_fmu.close()
        scalar_variables = xml.find('ModelVariables').findall('ScalarVariable')
        simple_types = xml.find('TypeDefinitions').findall('SimpleType')
        signal_types = get_signal_types_dymola(simple_types)
    # Find instances of 'Overwrite' or 'Read'
    for var in allvars:
        # Get instance name
        instance = '.'.join(var.split('.')[:-1])
        # Overwrite
        if 'boptestOverwrite' in var:
            label = 'Overwrite'
            unit = fmu.get_variable_unit(instance+'.u')
            # Description
            if tool == 'Dymola':
                description = get_parameter_dymola(scalar_variables, instance, 'description', 'String')
            else:
                description = fmu.get(instance+'.description')[0]
            mini = fmu.get_variable_min(instance+'.u')
            maxi = fmu.get_variable_max(instance+'.u')
        # Read
        elif 'boptestRead' in var:
            label = 'Read'
            # Unit
            if tool == 'Dymola':
                try:
                    unit = fmu.get_variable_unit(instance+'.y')
                except:
                    if 'CO2' in instance:
                        print('{0} does not have a unit. Assuming "ppm".'.format(instance))
                        unit = 'ppm'
            else:
                unit = fmu.get_variable_unit(instance+'.y')
            # Description
            if tool == 'Dymola':
                description = get_parameter_dymola(scalar_variables, instance, 'description', 'String')
            else:
                description = fmu.get(instance+'.description')[0]
            # Min and Max
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
            if tool == 'Dymola':
                signal_type = signal_types[get_parameter_dymola(scalar_variables, instance, 'KPIs', 'Enumeration')]
            else:
                signal_type = fmu.get_variable_declared_type(var).items[fmu.get(var)[0]][0]
            # Split certain signal types for multi-zone
            if signal_type in ['AirZoneTemperature',
                               'RadiativeZoneTemperature',
                               'OperativeZoneTemperature',
                               'RelativeHumidity',
                               'CO2Concentration']:
                if tool == 'Dymola':
                    string = get_parameter_dymola(scalar_variables, instance, 'zone', 'String')
                    signal_type = '{0}[{1}]'.format(signal_type, string)
                else:
                    signal_type = '{0}[{1}]'.format(signal_type, fmu.get(instance+'.zone')[0])

            if signal_type == 'ActuatorTravel':
                if tool == 'Dymola':
                    actuatorType_val = int(get_parameter_dymola(scalar_variables, instance, 'actuatorType', 'Enumeration'))
                else:
                    actuatorType_val = int(fmu.get(instance + '.actuatorType')[0])
                actuatorType_map = {
                    1: 'None', 2: 'Damper', 3: 'Valve', 4: 'Fan',
                    5: 'Pump', 6: 'HVACEquipment', 7: 'Others'
                }
                signal_type = 'ActuatorTravel[{0}]'.format(actuatorType_map.get(actuatorType_val, str(actuatorType_val)))

            if signal_type == 'None':
                continue
            elif signal_type in signals:
                signals[signal_type].append(_make_var_name(instance,style='output'))
            else:
                signals[signal_type] = [_make_var_name(instance,style='output')]

    # Clean up
    os.remove(fmu_path)
    os.remove(fmu_path.replace('.fmu', '_log.txt'))

    return instances, signals

def write_wrapper(model_path, file_name, instances, tool='JModelica', algorithm='Cvode', tolerance=1e-6):
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
    tool : str, optional
        FMU compilation tool. "JModelica" or "OCT" or "Dymola" supported.
        Default is "JModelica".
    algorithm : str, optional
        Specify the solver algorithm. For tool='Dymola' only. Options are 'Cvode', 'Dassl', 'Radau', 'Lsodar'.
        Default is 'Cvode'.
    tolerance : numeric, optional
        Specify the solver tolerance. For tool='Dymola' only.
        Default is 1e-6.

    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    wrapped_path : str or None
        Path to the wrapped modelica model if instances of signale exchange.
        Otherwise, None

    '''

    # Check solver option is valid
    valid_algorithms =  ['Cvode', 'Dassl', 'Radau', 'Lsodar']
    if (algorithm not in valid_algorithms) and (tool=='Dymola'):
        raise ValueError('Invalid algorithm "{0}" for tool Dymola.  Choose from {1}.'.format(algorithm, valid_algorithms))
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
            # Add outputs for every read block and overwrite block
            f.write('\t// Out read\n')
            for i in ['Read', 'Overwrite']:
                for block in instances[i].keys():
                    # Instantiate signal
                    f.write('\tModelica.Blocks.Interfaces.RealOutput {0} = mod.{1}.y "{2}";\n'.format(_make_var_name(block,style='output',attribute='(unit="{0}")'.format(instances[i][block]['Unit'])), block, instances[i][block]['Description']))
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
            # End file -- with hard line ending
            f.write('end wrapped;\n')
        # Export as fmu
        if tool == 'JModelica':
            from pymodelica import compile_fmu
            fmu_path = compile_fmu('wrapped', [wrapped_path]+file_name, jvm_args="-Xmx8g", target='cs')
        elif tool == 'OCT':
            from pymodelica import compile_fmu
            fmu_path = compile_fmu('wrapped', [wrapped_path]+file_name, modelicapath=modelicapath, jvm_args="-Xmx8g", target='cs')
        elif tool == 'Dymola':
            fmu_path = compile_fmu_dymola('wrapped', algorithm=algorithm, tolerance=tolerance)
        else:
            raise ValueError('Tool {0} unknown.'.format(tool))
    # If there are not, write and export wrapper model
    else:
        # Warn user
        warnings.warn('No signal exchange block instances found in model.  Exporting model as is.')
        # Compile fmu
        if tool == 'JModelica':
            from pymodelica import compile_fmu
            fmu_path = compile_fmu(model_path, file_name, jvm_args="-Xmx8g", target='cs')
        elif tool == 'OCT':
            from pymodelica import compile_fmu
            fmu_path = compile_fmu(model_path, file_name, modelicapath=modelicapath, jvm_args="-Xmx8g", target='cs')
        elif tool == 'Dymola':
            fmu_path = compile_fmu_dymola(model_path, algorithm=algorithm, tolerance=tolerance)
        else:
            raise ValueError('Tool {0} unknown.'.format(tool))
        wrapped_path = None

    return fmu_path, wrapped_path

def export_fmu(model_path, file_name, tool='JModelica', algorithm='Cvode', tolerance=1e-6):
    '''Parse signal exchange blocks and export boptest fmu and kpi json.

    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    file_name : list
        Path(s) to modelica file and required libraries not on MODELICAPATH.
        Passed to file_name parameter of pymodelica.compile_fmu() in JModelica.
    tool : str, optional
        FMU compilation tool. "JModelica" or "OCT" or "Dymola" supported.
        Default is "JModelica".
    algorithm : str, optional
        Specify the solver algorithm. For tool='Dymola' only. Options are 'Cvode', 'Dassl', 'Radau', 'Lsodar'.
        Default is 'Cvode'.
    tolerance : numeric, optional
        Specify the solver tolerance. For tool='Dymola' only.
        Default is 1e-6.

    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    kpi_path : str
        Path to kpi json

    '''

   # Check solver option is valid
    valid_algorithms =  ['Cvode', 'Dassl', 'Radau', 'Lsodar']
    if (algorithm not in valid_algorithms) and (tool=='Dymola'):
        raise ValueError('Invalid algorithm "{0}" for tool Dymola.  Choose from {1}.'.format(algorithm, valid_algorithms))
    # Get signal exchange instances and kpi signals
    instances, signals = parse_instances(model_path, file_name, tool, algorithm=algorithm, tolerance=tolerance)
    # Write wrapper and export as fmu
    fmu_path, _ = write_wrapper(model_path, file_name, instances, tool, algorithm=algorithm, tolerance=tolerance)
    # Write kpi json
    kpi_path = os.path.join(os.getcwd(), 'kpis.json')
    with open(kpi_path, 'w') as f:
        json.dump(signals, f)
    # Generate test case data
    man = Data_Manager()
    man.save_data_and_jsons(fmu_path=fmu_path)

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


if __name__ == '__main__':
    # Define model
    model_path = 'SimpleRC'
    mo_path = 'SimpleRC.mo'
    # Parse and export
    fmu_path, kpi_path = export_fmu(model_path, [mo_path])
    # Print information
    print('Exported FMU path is: {0}'.format(fmu_path))
    print('KPI json path is: {0}'.format(kpi_path))
