import imp
import sys

config_module = imp.new_module('config')
sys.modules['config'] = config_module


def get_test_config(fmupath):
    source = """
def get_config():
    c = dict()
    c['fmupath'] = '{}'
    c['step'] = 60
    c['horizon'] = 86400
    c['interval'] = 3600
    c['scenario'] = {{'electricity_price': 'constant'}}
    return c
"""

    format_source = source.format(fmupath)
    exec format_source in config_module.__dict__
