import imp
import sys
import zipfile

config_module = imp.new_module('config')
sys.modules['config'] = config_module

def define_config(fmupath):
    '''Function that dynamically defines config.get_config

    Based on the content of a config.py associated with the given fmu
    The main purpose of is to overwrite the fmupath defined in the 
    given config.py and replace it with the fmupath argument value 

    '''
    with zipfile.ZipFile(fmupath) as myzip:
        with myzip.open('resources/config.py') as myfile:
            config_source = myfile.read()

    exec(config_source)

    c = get_config()

    c['fmupath'] = fmupath
    config_module.__dict__['c'] = c

    new_source = """
def get_config():
    return c
"""

    exec(new_source, config_module.__dict__)

