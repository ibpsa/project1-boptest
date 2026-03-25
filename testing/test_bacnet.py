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
import signal

class Run(unittest.TestCase, utilities.partialTestTimePeriod):
    '''Tests an example deployment of the bacnet proxy.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'bestest_air'
        self.url = os.environ.get("BOPTEST_SERVER", 'http://127.0.0.1:8000')
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
        '''Test simple write/read with default bacnet proxy settings.

        '''

        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0 --baseurl {0}".format(self.url), shell=True, preexec_fn=os.setsid)
        time.sleep(10)
        r = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:35 presentValue 294".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                print(str(line))
                if 'New value seen!' in str(line):
                    success = True
                else:
                     print('test_read_write failed, value was not updated properly')
                     success = False
        time.sleep(15)
        os.killpg(os.getpgid(r.pid), signal.SIGTERM)
        os.killpg(os.getpgid(p.pid), signal.SIGTERM)

        self.assertTrue(success)

    def test_advance_faster_than_realtime(self):
        '''Test advancing the bacnet proxy faster than real time.

        60 second simulation step every 2 seconds of wall-clock time.

        '''

        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0 --app_interval=2 --simulation_step=60 --baseurl {0}".format(self.url), shell=True, preexec_fn=os.setsid)
        t_start = time.time()
        time.sleep(10)
        r = subprocess.Popen("cd bacnet/example && exec python SimpleRead.py {0}:5000 analogValue:2 presentValue".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        delta_t = time.time() - t_start

        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                if 'value' in str(line):
                    time_dict = json.loads(line)

        if time_dict['var'] == 'analogValue:2' and time_dict['value'] > delta_t:
            success = True
        else:
            print('test_advance_faster_than_realtime failed. Either time value was not found or time value is incorrect, check json response:')
            print('Variable name is: ' + time_dict['var'] + ' Simulation time is: ' + str(time_dict['value']) + 'and is lower than real time passed: ' + str(delta_t) )
            success = False

        time.sleep(15)
        os.killpg(os.getpgid(r.pid), signal.SIGTERM)
        os.killpg(os.getpgid(p.pid), signal.SIGTERM)

        self.assertTrue(success)

    def test_advance_oncommand(self):
        '''Test advancing the bacnet proxy on-command and resetting the on-command counter.

        '''

        time_advanced = 10
        p = subprocess.Popen("cd bacnet && exec python BopTestProxy.py bestest_air 0 0 --app_interval=oncommand --simulation_step={0} --baseurl={1}".format(time_advanced, self.url), shell=True, preexec_fn=os.setsid)
        time.sleep(10)
        w = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:1 presentValue 1".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        time.sleep(10)
        os.killpg(os.getpgid(w.pid), signal.SIGTERM)
        w1 = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:1 presentValue 0".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        time.sleep(10)
        os.killpg(os.getpgid(w1.pid), signal.SIGTERM)
        w2 = subprocess.Popen("cd bacnet/example && exec python SimpleReadWrite.py {0}:5000 analogOutput:1 presentValue 1".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        time.sleep(10)
        os.killpg(os.getpgid(w2.pid), signal.SIGTERM)
        r = subprocess.Popen("cd bacnet/example && exec python SimpleRead.py {0}:5000 analogValue:2 presentValue".format(self.ip), shell=True, preexec_fn=os.setsid, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

        with r.stdout:
            for line in iter(r.stdout.readline, b''):
                if 'value' in str(line):
                    time_dict = json.loads(line)

        if time_dict['var'] == 'analogValue:2' and time_dict['value'] - 2*time_advanced < 1E-6:
            success = True
        else:
            print('test_advance_oncommand failed. Either time value was not found or time value is incorrect, check json response:')
            print('Variable name is: ' + time_dict['var'] + ' Simulation time is: ' + str(time_dict['value']) + 'and is different from expected time: ' + str(2*time_advanced) )
            success = False

        time.sleep(15)
        os.killpg(os.getpgid(r.pid), signal.SIGTERM)
        os.killpg(os.getpgid(p.pid), signal.SIGTERM)

        self.assertTrue(success)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
