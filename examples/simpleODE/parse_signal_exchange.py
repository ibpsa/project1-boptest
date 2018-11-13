# -*- coding: utf-8 -*-
"""
This script implements a test of parsing the signal exchange blocks.

1) Use Modelica-Json to parse Modelica code
2) Load json and find signal exchange block class instances
3) Write Modelica wrapper around instantiated model
4) Export as FMU

"""

import subprocess
import json
import pprint
from pyfmi import load_fmu
from pymodelica import compile_fmu

pp = pprint.PrettyPrinter(indent=2)

def parse_json(mo_filepath):
    '''Use Modelica-Json to parse the Modelica file.
    
    Parameters
    ----------
    mo_filepath : str
        File path of the Modelica file to parse
    
    Returns
    -------
    mo_json : dict
        Dictionary representing the output of Modelica-Json
        
    '''

    # Run modelica-json
    command = 'node /home/dhb-lx/git/antlr/modelica-json/app.js -f author/TestOverWrite_Unpacked/ -o json-simplified -m modelica'
    subprocess.check_output(command.split(' '))
    # Load json output
    with open('author/TestOverWrite_Unpacked/simplified/TestOverWrite_Unpacked.OriginalModel.json') as f:
        mo_json = json.load(f)[0]
    
    return mo_json
    
def get_classes_json(mo_json):
    '''Find the signal exchange block class instances in a modelica-json.
    
    Parameters
    ----------
    mo_json : dict
        Dictionary representing the output of Modelica-Json
        
    Returns
    -------
    classes : dict
        Dictionary of overwrite and read block class lists.
        {'Overwrite': [str], 'Read': [str]}
        
    '''
    
    # Initialize dictionary
    classes = {'Overwrite':[], 'Read':[]}
    # Find classes of 'Overwrite' or 'Read'
    for model in mo_json['public']['models']:
        if model['className'] == u'Overwrite':
            classes['Overwrite'].append(model['name'])
        elif model['className'] == u'Read':
            classes['Read'].append(model['name'])
            
    return classes
    
def get_classes_xml(model_path, mo_path):
    '''Find the signal exchange block class instances using fmu xml.
    
    Parameters
    ----------
    model_path : str
        Path to modelica model
    mo_path : str
        Path to modelica file
        
    Returns
    -------
    classes : dict
        Dictionary of overwrite and read block class lists.
        {'Overwrite': [str], 'Read': [str]}
        
    '''
    # Compile fmu
    fmu_path = compile_fmu(model_path, mo_path)
    # Load fmu
    fmu = load_fmu(fmu_path)
    # Check version
    if fmu.get_version() != '2.0':
        raise ValueError('FMU version must be 2.0')
    # Get all parameters
    par_names = fmu.get_model_variables(causality = 0).keys()
    # Initialize dictionary
    classes = {'Overwrite':[], 'Read':[]}
    # Find classes of 'Overwrite' or 'Read'
    for par in par_names:
        # Overwrite
        if 'is_overwrite' in par:
            label = 'Overwrite'
        # Read
        elif 'is_read' in par:
            label = 'Read'
        else:
            continue
        # Get class instance name
        instance = '.'.join(par.split('.')[:-1])
        # Save instance name with label
        classes[label].append(instance)
            
    return classes
    
def write_wrapper(model_path, mo_path, classes):
    '''Write the wrapper modelica model and export as fmu
    
    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    mo_path : str
        Path to orginal modelica file
    classes : dict
        Dictionary of overwrite and read block class lists.
        {'Overwrite': [str], 'Read': [str]}

    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    wrapped_path : str
        Path to the wrapped modelica model

    '''

    # Define wrapper modelica file path
    wrapped_path = 'wrapped.mo'
    # Open file
    with open(wrapped_path, 'w') as f:
        # Start file
        f.write('model wrapped "Wrapped model"\n')
        # Add inputs for every overwrite block
        f.write('\t// Input overwrite\n')
        input_signals = dict()
        input_activate = dict()
        for block in classes['Overwrite']:
            # Replace dots with lines
            var_name = block.replace('.', '_')
            # Add to signal input list
            input_signals[block] = '{0}_u'.format(var_name)
            # Add to signal activate list
            input_activate[block] = '{0}_activate'.format(var_name)
            # Instantiate input signal
            f.write('\tModelica.Blocks.Interfaces.RealInput {0} "Signal for overwrite block {1}";\n'.format(input_signals[block], block))
            # Instantiate input activation
            f.write('\tModelica.Blocks.Interfaces.BooleanInput {0} "Activation for overwrite block {1}";\n'.format(input_activate[block], block))
        # Add outputs for every read block
        f.write('\t// Out read\n')
        for block in classes['Read']:
            # Replace dots with lines
            var_name = block.replace('.', '_')
            # Instantiate input signal
            f.write('\tModelica.Blocks.Interfaces.RealOutput {0}_y = mod.{1}.y "Measured signal for {1}";\n'.format(var_name, block))
        # Add original model
        f.write('\t// Original model\n')
        f.write('\t{0} mod(\n'.format(model_path))
        # Connect inputs to original model overwrite and activate signals
        for i,block in enumerate(classes['Overwrite']):
            f.write('\t\t{1}(uExt(y={0})),\n'.format(input_signals[block], block))
            f.write('\t\t{1}(activate(y={0}))'.format(input_activate[block], block))   
            if i == len(classes['Overwrite'])-1:
                f.write(') "Original model with overwrites";\n')
            else:
                f.write(',\n')
        # End file
        f.write('end wrapped;')
    # Export as fmu
    fmu_path = compile_fmu('wrapped', ['wrapped.mo', mo_path])
        
    return fmu_path, wrapped_path
        


if __name__ == '__main__':
    model_path = 'TestOverWrite.OriginalModelStacked'
    mo_path = 'author/TestOverWrite.mo'
    # Get classes
    classes = get_classes_xml(model_path, mo_path)
    # Write wrapper
    write_wrapper(model_path, mo_path, classes)
    # Print
    pp.pprint(classes)


    

