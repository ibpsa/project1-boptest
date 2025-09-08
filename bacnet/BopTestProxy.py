# -*- coding: utf-8 -*-

"""
BOPTEST Proxy Server

This sample application uses BOPTEST framework to create a virtual building
and make it available over BACnet. To run it, follow the install instructions
on the README.md.

This code is based on a prototype written by Erik Paulson (https://github.com/epaulson/boptest-bacnet-proxy)
and is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

"""

import os
import requests
import time
import json
import rdflib

from bacpypes.debugging import bacpypes_debugging, ModuleLogger
from bacpypes.consolelogging import ConfigArgumentParser

from bacpypes.core import run
from bacpypes.task import RecurringTask

from bacpypes.basetypes import DateTime
from bacpypes.primitivedata import Real
from bacpypes.object import AnalogValueObject, DateTimeValueObject

from bacpypes.app import BIPSimpleApplication
from bacpypes.service.device import DeviceCommunicationControlServices
from bacpypes.service.object import ReadWritePropertyMultipleServices
from bacpypes.local.device import LocalDeviceObject
from bacpypes.local.object import AnalogValueCmdObject, Commandable, AnalogOutputCmdObject
from bacpypes.object import register_object_type, AnalogInputObject

# some debugging
_debug = 0
_log = ModuleLogger(globals())

# dictionary of names to objects
objects = {}
inputs = {}
activation_signal = {}
nextState = None
g = None

baseurl = "http://127.0.0.1:80"
boptest_measurements = None
boptest_inputs = None
advance_counter = 0

# TODO - what should some of the BOPTEST objects be - maybe
# AnalogInputs or BinaryInputs?
# Not currently using this class
# TODO - why does BACpyes have a builtin AnalogValueCmdObject but not a builtin AnalogInputCmdObject?
@bacpypes_debugging
@register_object_type(vendor_id=999)
class AnalogInputCmdObject(Commandable(Real), AnalogInputObject):
    def _set_value(self, value):
        if _debug:
            AnalogInputCmdObject._debug("_set_value %r", value)

        # numeric values are easy to set
        self.presentValue = value

# We are using this class
# TODO - why are we using this class instead of just AnalogValueCmdObject?
# This was how OpenWeatherServer.py did it - was it just so it could log the change?
@bacpypes_debugging
@register_object_type(vendor_id=999)
class LocalAnalogValueObject(AnalogValueCmdObject):
    def _set_value(self, value):
        if _debug:
            LocalAnalogValueObject._debug("_set_value %r", value)

        # numeric values are easy to set
        self.presentValue = value

klassMapping = {'analog-value': LocalAnalogValueObject, 'analog-input': AnalogInputObject, 'analog-output': AnalogOutputCmdObject}
unitMapping = {'K': "degreesKelvin", 'ppm': "partsPerMillion"}


@bacpypes_debugging
def create_objects(app, configfile, oncommand):
    """Create the objects that hold the result values.

    Parameters
    ----------
    configfile : str
        File path for .ttl BACnet objects configuration file.
    oncommand : bool
        Indicator of whether app refresh interval is =on-command by user.

    """

    if _debug:
        create_objects._debug("create_objects %r", app)
    global objects, inputs, g, nextState

    g= rdflib.Graph()
    g.parse(configfile)
    points = g.query("select ?point ?name ?bacnetRef ?statusFlags ?unit where {?point ref:hasExternalReference ?bo . ?bo bacnet:object-identifier ?bacnetRef . ?bo bacnet:object-name ?name . ?bo bacnet:status-flags ?statusFlags OPTIONAL {?point brick:hasUnit ?unit} }")
    for point in points:
        rdfBacnetName = point[1]
        rdfBacnetRef = point[2]
        rdfStatusFlags = point[3]
        rdfBacnetUnit = point[4]

        if _debug:
            create_objects._debug("    - name: %r", point[1])
        klassName, instanceNum = rdfBacnetRef.split(",", 2)
        klass = klassMapping[klassName]
        instanceNum = int(instanceNum)
        name = str(rdfBacnetName)
        units = None
        if rdfBacnetUnit:
            units = unitMapping[str(rdfBacnetUnit)]

        initialValue = None
        if name in nextState['payload']:
            initialValue = nextState['payload'][name]
        else:
            initialValue = 0.0

        statusFlagsList=[int(str(rdfStatusFlags))]

        if klassName == 'analog-input' or klassName == 'analog-value':
            obj = klass(objectName = name, objectIdentifier=(klass.objectType, instanceNum), presentValue=initialValue,statusFlags=statusFlagsList)
        else:
            obj = klass(objectName = name, objectIdentifier=(klass.objectType, instanceNum), presentValue=initialValue, relinquishDefault = initialValue,statusFlags=statusFlagsList)
        if _debug:
            create_objects._debug("    - obj: %r", obj)

        if units is not None:
            obj.units = units

        # add it to the application
        app.add_object(obj)
        # keep track of the object by name
        objects[name] = obj
        if name in boptest_inputs['payload']:
            activation_name = name[:-2] + "_activate"
            # TODO: Check to make sure there actually is an activation signal!
            activation_signal[name] = activation_name
            inputs[name] = obj
        elif name in 'advance':
            inputs[name] = obj

@bacpypes_debugging
class BOPTESTUpdater(RecurringTask):

    """
    An instance of this class pops up out of the ground every once in a
    while and write out the next value.
    """

    def __init__(self, interval, oncommand):

        self.oncommand = oncommand
        # if oncommand == True start counter at 0 and simulation advances
        # when advance input > self.advance_counter. If oncommand == false
        # self.advance_counter == -1 and simulation advances automatically
        if self.oncommand:
            self.advance_counter = 0
        else:
            self.advance_counter = -1

        if _debug:
            self._debug("__init__ %r", interval)
            self._debug("__init__ %r", oncommand)
            self._debug("__init__ Setting advance counter")
            self._debug("__init__ %r", self.advance_counter)
        RecurringTask.__init__(self, interval)

        # install it
        self.install_task()

    def process_task(self):
        """Read the current simulation data from the API and set the object values."""

        global objects, inputs, baseurl, testid, advance_counter

        if _debug and (advance_counter > self.advance_counter):
            self._debug("update_boptest_data")
        # ask the web service
        # We get results direct from /advance now but you could ask the simulation for historic data
        # response = requests.put(
        #    "http://localhost:5000/results", json={'point_name':'TRooAir_y', 'start_time': timestep * 30, 'final_time': (timestep+1)*30}
        #)

        signals = {}

        for signal_name, signal_activation in activation_signal.items():
            signals[signal_activation] = 0.0

        # For "commandable" objects, BACnet maintains a priorityArray that can be written to from levels 1-16, which are
        # used to replace the 'presentValue' of an object. So, for the points that are 'inputs' in BOPtest, we created those as
        # commandable objects, so check to see if there is a higher priority value set for this object that is overwriting
        # what we should normally use - and if so, turn on the '_activate' signal for that point as well
        #
        # (BACpypes automatically turns a write to presentValue into a write to the priority array) - e.g. a client that
        # does this from a client:
        # python samples/ReadWriteProperty.py
        # > write 10.0.2.7 analogValue:63 presentValue 310
        #
        # BACpypes-based servers will change that into a modification of priorityArray at priority 16
        #
        # the _activate signals are sticky in BOPtest, so we turn them off by default and only turn them back on when
        # there is a signal to overwrite. Because they are sticky we could just leave out any that were previously set to 0
        # but by just setting them all to 0, we don't have to worry about tracking any state, at the expense of sending in a
        # bunch of parameters to boptest that don't really do anything
        #
        for k,v in inputs.items():
            #print("k: %s %s %s" % (str(k), v._highest_priority_value(), type(v._highest_priority_value()[1])))
            signal = v._highest_priority_value()
            if signal[1]:                
                if k == 'advance' and self.oncommand:
                    advance_counter = signal[0]
                else:
                    signals[k] = signal[0]
                    activation_name = activation_signal[k]
                    signals[activation_name] = 1.0

        # Advancing simulation if counter is higher than previous value
        # if oncommand == False the statement is always True

        if advance_counter > self.advance_counter:


            if _debug:
                _log.debug('Advancing one step ' + time.strftime("%H:%M:%S", time.localtime()))

            response = requests.post('{0}/advance/{1}'.format(baseurl,testid), json=signals)
            if response.status_code != 200:
                print("Error response: %r" % (response.status_code,))
                return

            # turn the response string into a JSON object
            json_response = response.json()

        # set the object values
        # We advance the simulation by x seconds at each call to the loop, but we don't update the external world
        # with those results until the NEXT call to this function.
        #
        # TODO: don't ACK BACnet writes until we get to here - instead, buffer the write request and send the ACKs later
        # don't worry about concurrency, last-writer-wins is fine, but be sure to send multiple acks, one to each writer
        global nextState
        if nextState:
            for k, v in nextState['payload'].items():
                if _debug and (advance_counter > self.advance_counter):
                    self._debug("    - k, v: %r, %r", k, v)

                if k in objects:
                    #objects[k]._set_value(v)
                    objects[k].presentValue = v

        if advance_counter > self.advance_counter:
            nextState = json_response
            if _debug and (self.advance_counter > 0):
                _log.debug('Increasing counter to: %r', advance_counter)
            if self.oncommand:
                self.advance_counter = advance_counter
        elif abs(advance_counter - 0.0) < 1E-6:
            if _debug and (self.advance_counter > 0):
                _log.debug('Resetting counter to: %r', advance_counter)
            if self.oncommand:
                self.advance_counter = advance_counter


# BAC0 uses the ReadPropertyMultiple service so make that available
@bacpypes_debugging
class ReadPropertyMultipleApplication(
   BIPSimpleApplication,
   ReadWritePropertyMultipleServices,
   DeviceCommunicationControlServices,
   ):
   pass

@bacpypes_debugging
def main():
    global vendor_id, g, baseurl

    parser = ConfigArgumentParser(description=__doc__)

    parser.add_argument('testcase', type=str, help="Name of BOPTEST test case to deploy.")
    parser.add_argument('start_time', type=int, default=0, help="Timestamp (in seconds) at which to start the simulation.")
    parser.add_argument('warmup_period', type=int, default=0, help="Timestamp (in seconds) at which to start the simulation.")
    parser.add_argument('--baseurl','-u', dest='baseurl', type=str, default='http://127.0.0.1:80', help="URL for BOPTest endpoint.")
    parser.add_argument('--app_interval','-ai', type=str, default='5', help="Application refresh interval time in seconds, which triggers simulation advancement and data exchange. Using value 'oncommand' will give user control of refresh upon incrementing a positive integer value of an additional new BACnet point named 'advance'.")
    parser.add_argument('--simulation_step','-s', type=str, default='5', help="Simulation advance time step in seconds, with each application refresh.")

    # parse the command line arguments
    args = parser.parse_args()
    baseurl = args.baseurl
    simulation_step = float(args.simulation_step)

    if "oncommand" in args.app_interval:
        oncommand = True
        APPINTERVAL = 100
    else:
        oncommand = False
        APPINTERVAL = float(args.app_interval)*1000
        if (APPINTERVAL/1000 < 0.5):
            _log.warning("WARNING: application refresh interval is less than 0.5 seconds, this may not be enough time for simulation to advance by one timestep")

    if _debug:
        _log.debug("initialization")
    if _debug:
        _log.debug("    - args: %r", args)

    # TODO: check the results to make sure we acutally get an OK!
    #
    global nextState
    global testid

    testid = requests.post("{0}/testcases/{1}/select".format(baseurl, args.testcase)).json()["testid"]
    res = requests.put('{0}/initialize/{1}'.format(baseurl,testid), json={'start_time':args.start_time, 'warmup_period':args.warmup_period} ).json()
    nextState = res

    global boptest_measurements, boptest_inputs
    boptest_measurements = requests.get('{0}/measurements/{1}'.format(baseurl,testid)).json()
    boptest_inputs = requests.get('{0}/inputs/{1}'.format(baseurl,testid)).json()

    # We advance the simulation by "simulation_step" seconds at each call to /advance.
    # if "APPINTERVAL" == "simulation_step" the simulation moves in sync with wallclock time.
    # To see things happen faster, set "simulation_step" > "APPINTERVAL"
    res = requests.put('{0}/step/{1}'.format(baseurl,testid), json={'step':simulation_step})

    # make a device object
    this_device = LocalDeviceObject(ini=args.ini)
    print(args.ini)
    if _debug:
        _log.debug("    - this_device: %r", this_device)

    # make a sample application
    this_application = ReadPropertyMultipleApplication(this_device, args.ini.address)

    # create the objects and add them to the application
    test_case_name = requests.get('{0}/name/{1}'.format(baseurl,testid)).json()['payload']['name']
    # create json file with testid
    testid_dict = {'testid': testid}
    with open('testid.json', 'w') as f:
        json.dump(testid_dict, f)

    file_name = '../testcases/{0}/models/bacnet.ttl'.format(test_case_name)
    create_objects(this_application, file_name, oncommand)

    # run this update when the stack is ready
    if _debug:
        _log.debug('Start simulation ' + time.strftime("%H:%M:%S", time.localtime()))
    updater = BOPTESTUpdater(APPINTERVAL, oncommand)

    if _debug:
        _log.debug("    - updater: %r", updater)

    if _debug:
        _log.debug("running")

    run()

    # shutdown test case when done
    res = requests.put("{0}/stop/{1}".format(baseurl, testid))
    if res.status_code == 200:
        _log.debug('Done shutting down test case.')
    else:
        _log.debug('Error shutting down test case.')
    if _debug:
        _log.debug("fini")


if __name__ == "__main__":
    main()
