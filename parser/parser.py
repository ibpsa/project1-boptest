# -*- coding: utf-8 -*-
"""
Implements the parsing and code generation for signal exchange blocks.

The steps are:
1) Compile Modelica code into fmu
2) Use signal exchange block id parameters to find block instance paths
3) Write Modelica wrapper around instantiated model
4) Export as wrapper FMU

"""

from pyfmi import load_fmu
from pymodelica import compile_fmu
import os
  
def get_instances(model_path, mo_path):
    '''Find the signal exchange block class instances using fmu xml.
    
    Parameters
    ----------
    model_path : str
        Path to modelica model
    mo_path : str
        Path to modelica file
        
    Returns
    -------
    instances : dict
        Dictionary of overwrite and read block class instance lists.
        {'Overwrite': [str], 'Read': [str]}
        
    '''

    # Signal exchange block library path
    se_lib = 'TestOverWrite.mo'
    # Compile fmu
    fmu_path = compile_fmu(model_path, [mo_path,se_lib])
    # Load fmu
    fmu = load_fmu(fmu_path)
    # Check version
    if fmu.get_version() != '2.0':
        raise ValueError('FMU version must be 2.0')
    # Get all parameters
    par_names = fmu.get_model_variables(causality = 0).keys()
    # Initialize dictionary
    instances = {'Overwrite':[], 'Read':[]}
    # Find instances of 'Overwrite' or 'Read'
    for par in par_names:
        # Overwrite
        if 'is_overwrite' in par:
            label = 'Overwrite'
        # Read
        elif 'is_read' in par:
            label = 'Read'
        else:
            continue
        # Get instance name
        instance = '.'.join(par.split('.')[:-1])
        # Save instance name with label
        instances[label].append(instance)
    # Clean up
    os.remove(fmu_path)
    os.remove(fmu_path.replace('.fmu', '_log.txt'))
            
    return instances
    
def write_wrapper(model_path, mo_path, instances):
    '''Write the wrapper modelica model and export as fmu
    
    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    mo_path : str
        Path to orginal modelica file
    instances : dict
        Dictionary of overwrite and read block class instance lists.
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
        for block in instances['Overwrite']:
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
        for block in instances['Read']:
            # Replace dots with lines
            var_name = block.replace('.', '_')
            # Instantiate input signal
            f.write('\tModelica.Blocks.Interfaces.RealOutput {0}_y = mod.{1}.y "Measured signal for {1}";\n'.format(var_name, block))
        # Add original model
        f.write('\t// Original model\n')
        f.write('\t{0} mod(\n'.format(model_path))
        # Connect inputs to original model overwrite and activate signals
        for i,block in enumerate(instances['Overwrite']):
            f.write('\t\t{1}(uExt(y={0})),\n'.format(input_signals[block], block))
            f.write('\t\t{1}(activate(y={0}))'.format(input_activate[block], block))   
            if i == len(instances['Overwrite'])-1:
                f.write(') "Original model with overwrites";\n')
            else:
                f.write(',\n')
        # End file
        f.write('end wrapped;')
    # Signal exchange block library path
    se_lib = 'TestOverWrite.mo'
    # Export as fmu
    fmu_path = compile_fmu('wrapped', ['wrapped.mo', mo_path, se_lib])
        
    return fmu_path, wrapped_path

def export_fmu(model_path, mo_path):
    '''Parse signal exchange blocks and export boptest fmu.
    
    Parameters
    ----------
    model_path : str
        Path to orginal modelica model
    mo_path : str
        Path to orginal modelica file
        
    Returns
    -------
    fmu_path : str
        Path to the wrapped modelica model fmu
    wrapped_path : str
        Path to the wrapped modelica model

    '''

    # Get signal exchange instances
    instances = get_instances(model_path, mo_path)
    # Write wrapper and export as fmu
    fmu_path, wrapped_path = write_wrapper(model_path, mo_path, instances)
    
    return fmu_path
    
if __name__ == '__main__':
    # Define model
    model_path = 'TestOverWrite.OriginalModelStacked'
    mo_path = 'TestOverWrite.mo'
    # Parse and export
    fmu_path = export_fmu(model_path, mo_path)
    # Print information
    print('Exported FMU path is: {0}'.format(fmu_path))


    

