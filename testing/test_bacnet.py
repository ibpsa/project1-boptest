# -*- coding: utf-8 -*-
"""
This module runs tests for the bacent proxy.

"""

import unittest
import os
import utilities
import subprocess
import time
import json

class Run(unittest.TestCase, utilities.partialTestTimePeriod):
    '''Tests an example deployment of the bacnet proxy.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'bestest_air'
        self.write_bacpypes_ini('bacnet/BACpypes')
        self.write_bacpypes_ini('bacnet/example/BACpypes')

    def tearDown(self):
        '''Shut down for each test.

        '''

        self.remove_bacpypes_ini('bacnet/BACpypes')
        self.remove_bacpypes_ini('bacnet/example/BACpypes')

    def write_bacpypes_ini(self, filepath):
        '''Write a BACpypes.ini file for the current resource.

        Parameters
        ==========
        filepath: str. Path to template BACpypes.ini file (omit .ini)

        Returns
        =======
        None

        '''

        self.ip = subprocess.run("hostname -I | cut -f1 -d' '", text=True, shell=True, capture_output=True).stdout.strip()
        with open('{0}.ini'.format(filepath), 'r') as f:
            s = f.read().replace('xxx.xxx.xxx.xxx', self.ip)
        with open('{0}_use.ini'.format(filepath), 'w') as f:
            f.write(s)
        subprocess.run("mv {0}.ini {0}_temp.ini".format(filepath), shell=True)
        subprocess.run("mv {0}_use.ini {0}.ini".format(filepath), shell=True)

    def remove_bacpypes_ini(self, filepath):
        '''Remove a BACpypes.ini file for the current resource and replace with template.

        Parameters
        ==========
        filepath: str. Path to template BACpypes.ini file (omit .ini)

        Returns
        =======
        None

        '''

        subprocess.run("rm {0}.ini".format(filepath), shell=True)
        subprocess.run("mv {0}_temp.ini {0}.ini".format(filepath), shell=True)

    def test_read_write(self):
        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0", shell=True)
        r = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:34 presentValue 294".format(self.ip), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                print(str(line))
                if 'New value seen!' in str(line):
                    success = True
                else:
                    success = False
        time.sleep(15)
        r.kill()
        p.kill()

        self.assertTrue(success)
    
    def test_advance_faster_than_realtime(self):
        
        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0 --app_interval=2 --simulation_step=10", shell=True)
        t_start = time.time()
        time.sleep(10)
        r = subprocess.Popen("cd bacnet/example && exec python SimpleRead.py {0}:5000 analogValue:1 presentValue".format(self.ip), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        delta_t = time.time() - t_start
        
        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                if 'value' in str(line):
                    time_dict = json.loads(line)

        if time_dict['var'] == 'analogValue:1' and time_dict['value'] > delta_t:
            success = True
        else:
            print('Either time value was not found or time value is incorrect, check json response:')
            print('Variable name is: ' + time_dict['var'] + ' Simulation time is: ' + str(time_dict['value']) + 'and is lower than real time passed: ' + str(delta_t) )
            success = False
        
        time.sleep(15)
        r.kill()
        p.kill()

        self.assertTrue(success)
        
    def test_advance_oncommand(self):
        time_advanced = 10
        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0 --app_interval=oncommand --simulation_step={0}".format(time_advanced), shell=True)
        w = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:37 presentValue 1".format(self.ip), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        time.sleep(10)
        w.kill()
        r = subprocess.Popen("cd bacnet/example && exec python SimpleRead.py {0}:5000 analogValue:1 presentValue".format(self.ip), shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        
        
        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                if 'value' in str(line):
                    time_dict = json.loads(line)

        if time_dict['var'] == 'analogValue:1' and time_dict['value'] - time_advanced < 1E-6:
            success = True
        else:
            success = False
        
        time.sleep(15)
        r.kill()
        p.kill()

        self.assertTrue(success)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
