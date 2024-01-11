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

from bacpypes.core import run, deferred
from bacpypes.task import recurring_function

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

# application interval is refresh time in seconds
APPINTERVAL = 5 * 1000 # 5 seconds

# dictionary of names to objects
objects = {}
inputs = {}
activation_signal = {}
nextState = None
g = None

baseurl = "http://localhost:5000"
boptest_measurements = None
boptest_inputs = None

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
def create_objects(app, configfile):
    """Create the objects that hold the result values."""
    if _debug:
        create_objects._debug("create_objects %r", app)
    global objects, inputs, g, nextState

    g= rdflib.Graph()
    g.parse(configfile)
    points = g.query("select ?point ?name ?bacnetRef ?unit where {?point ref:hasExternalReference ?bo . ?bo bacnet:object-identifier ?bacnetRef . ?bo bacnet:object-name ?name OPTIONAL {?point brick:hasUnit ?unit} }")
    for point in points:
        rdfBacnetName = point[1]
        rdfBacnetRef = point[2]
        rdfBacnetUnit = point[3]
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
        if klassName == 'analog-input' or klassName == 'analog-value':
            obj = klass(objectName = name, objectIdentifier=(klass.objectType, instanceNum), presentValue=initialValue)
        else:
            obj = klass(objectName = name, objectIdentifier=(klass.objectType, instanceNum), relinquishDefault = initialValue)
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

@recurring_function(APPINTERVAL)
@bacpypes_debugging
def update_boptest_data():
    """Read the current simulation data from the API and set the object values."""
    if _debug:
        update_boptest_data._debug("update_boptest_data")
    global objects, inputs, baseurl

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
            signals[k] = signal[0]
            activation_name = activation_signal[k]
            signals[activation_name] = 1.0


    #print("Advancing with signals: " + str(signals))
    response = requests.post(
    #    "http://localhost:5000/advance", json={"oveAct_u": next_oveAct_u, "oveAct_activate": next_oveAct_activate}
        '{0}/advance'.format(baseurl), json=signals

    )
    if response.status_code != 200:
        print("Error response: %r" % (response.status_code,))
        return

    # turn the response string into a JSON object
    json_response = response.json()

    # set the object values
    # We advance the simulation by 5 seconds at each call to the loop, but we don't update the external world
    # with those results until the NEXT call to this function.
    #
    # TODO: don't ACK BACnet writes until we get to here - instead, buffer the write request and send the ACKs later
    # don't worry about concurrency, last-writer-wins is fine, but be sure to send multiple acks, one to each writer
    #
    # TODO: rather than using recurring_function, we should schedule ourselves to be called again at (5secs-elapsed_function_time)
    # because if say the call to /advance takes 3 seconds, we want to get called again in 2 seconds, not in 5 seconds.
    global nextState
    if nextState:
        for k, v in nextState['payload'].items():
            if _debug:
                update_boptest_data._debug("    - k, v: %r, %r", k, v)

            if k in objects:
                #objects[k]._set_value(v)
                objects[k].presentValue = v

    nextState = json_response

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

    parser.add_argument('start_time', type=int, default=0, help="timestamp (in seconds) at which to start the simulation")
    parser.add_argument('warmup_period', type=int, default=0, help="timestamp (in seconds) at which to start the simulation")
    parser.add_argument('--baseurl', dest='baseurl', type=str, default='http://localhost:5000', help="URL for BOPTest endpoint")
    # parse the command line arguments
    args = parser.parse_args()
    baseurl = args.baseurl

    if _debug:
        _log.debug("initialization")
    if _debug:
        _log.debug("    - args: %r", args)

    # TODO: check the results to make sure we acutally get an OK!
    #
    global nextState

    res = requests.put('{0}/initialize'.format(baseurl), json={'start_time':args.start_time, 'warmup_period':args.warmup_period} ).json()
    nextState = res

    global boptest_measurements, boptest_inputs
    boptest_measurements = requests.get(baseurl + "/measurements").json()
    boptest_inputs = requests.get(baseurl+"/inputs").json()

    # We advance the simulation by 5 seconds at each call to /advance, and APPINTERVAL is also 5 seconds, so the simulationo
    # moves in sync with wallclock time. To see things happen faster, set this time greater than 5 seconds
    res = requests.put('{0}/step'.format(baseurl), json={'step':5})

    # make a device object
    this_device = LocalDeviceObject(ini=args.ini)
    if _debug:
        _log.debug("    - this_device: %r", this_device)

    # make a sample application
    this_application = ReadPropertyMultipleApplication(this_device, args.ini.address)

    # create the objects and add them to the application
    test_case_name = requests.get('{0}/name'.format(baseurl)).json()['payload']['name']
    file_name = '../testcases/{0}/models/bacnet.ttl'.format(test_case_name)
    create_objects(this_application, file_name)

    # run this update when the stack is ready
    deferred(update_boptest_data)

    if _debug:
        _log.debug("running")

    run()

    if _debug:
        _log.debug("fini")


if __name__ == "__main__":
    main()
