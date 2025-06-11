#!/usr/bin/env python

"""
This application takes an address, an object id, property, and value and
changes it, but reads it first and then reads it again after the write.

This code is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

"""

import sys
from math import isclose
from collections import deque
from bacpypes.debugging import bacpypes_debugging, ModuleLogger
from bacpypes.consolelogging import ConfigArgumentParser

from bacpypes.core import run, deferred, stop, enable_sleeping
from bacpypes.iocb import IOCB

from bacpypes.primitivedata import ObjectIdentifier, CharacterString, Null, Null, Atomic, Boolean, Unsigned, Integer, \
    Real, Double, OctetString, CharacterString, BitString, Date, Time, ObjectIdentifier
from bacpypes.constructeddata import ArrayOf, Array, AnyAtomic, Any

from bacpypes.pdu import Address
from bacpypes.apdu import ReadPropertyRequest, ReadPropertyACK, WritePropertyRequest, SimpleAckPDU

from bacpypes.app import BIPSimpleApplication
from bacpypes.local.device import LocalDeviceObject
from bacpypes.object import get_datatype

from bacpypes.task import FunctionTask

_debug = 0
_log = ModuleLogger(globals())

# globals
this_device = None
this_application = None

#
# control flow:
# 1. main starts an event loop and registers a callback for read_property() to kick off right away
#    main also sets a phase flag to 'first_read' in the context obj that goes into the callback
# 2. read_property gets called and issues a read request for requested property, and sets a callback for complete_read_property_request and passes the context obj to the callback
# 3. complete_read_property_request wakes up when the ack for the network request is received and looks to see what phase we're in
#    if we're in the first_read phase, it compares the bacnet property value it reads to what it's supposed to be changed to
#    if the property is already what it's supposed to change to, the program exits since we can't test if a change happened
#    if the property value is different, then the complete_read_property_request schedules a write request
#    (we probably don't need to make a callback to issue the write request, we could have just issued it in the complete_read_request callback)
# 4. In issue_write_request, the write request is sent and a callback is registered to handle the response in complete_write_property_request
# 5. the acknowledgement for the write request is handled in complete_write_property_request.
#    assuming we got the ack, complete_write_property_request schedules another read_property() to run 1 second later
#    to verify that the change has taken place
#    The context object is changed to switch the phase we're in
# 6. read_property gets called again and issues a read request for requested property, and sets a callback for complete_read_property_request and passes the context obj to the callback
# 7. complete_read_property_request wakes up when the ack for the network request is received and looks to see what phase we're in
#    if we're in the 'check-write' phase, it compares the bacnet property value it reads to what it's supposed to be changed to
#    if the property is already what it's supposed to be, great, we're done and the program exits
#    if the property value is different, then the complete_read_property_request schedules another read_property request to happen 1 second later
#    However, if we've already tried 10 times to read the property, we exit the program
#

@bacpypes_debugging
class BOPTESTBacnetClientTestApplication(BIPSimpleApplication):
    def __init__(self, *args):
        if _debug: BOPTESTBacnetClientTestApplication._debug("__init__ %r", args)
        BIPSimpleApplication.__init__(self, *args)

    def read_property(self, context_obj):
        addr = context_obj['addr']
        obj_id = context_obj['obj_id']
        prop_id = context_obj['prop_id']
        try:
            obj_id = ObjectIdentifier(obj_id).value
            if prop_id.isdigit():
                prop_id = int(prop_id)

            datatype = get_datatype(obj_id[0], prop_id)
            if not datatype:
                raise ValueError("invalid property for object type")

            # build a request
            request = ReadPropertyRequest(
                objectIdentifier=obj_id, propertyIdentifier=prop_id
            )
            request.pduDestination = Address(addr)

            if _debug:
                BOPTESTBacnetClientTestApplication._debug("    - request: %r", request)


            iocb = IOCB(request)
            if _debug:
                BOPTESTBacnetClientTestApplication._debug("    - iocb: %r", iocb)

            # give it to the application
            iocb.add_callback(self.complete_read_property_request, context_obj)
            this_application.request_io(iocb)

        except Exception as error:
            BOPTESTBacnetClientTestApplication._exception("exception: %r", error)

    def complete_read_property_request(self, iocb, context_obj):
        try:
            # do something for error/reject/abort
            if iocb.ioError:
                BOPTESTBacnetClientTestApplication._exception("exception: %s", iocb.ioError)


            elif iocb.ioResponse:
                apdu = iocb.ioResponse

                # should be an ack
                if not isinstance(apdu, ReadPropertyACK):
                    if _debug:
                        BOPTESTBacnetClientTestApplication._debug("    - not an ack in read_property_request_ack")
                    return

                # find the datatype
                datatype = get_datatype(
                    apdu.objectIdentifier[0], apdu.propertyIdentifier
                )
                if _debug:
                    BOPTESTBacnetClientTestApplication._debug("    - datatype: %r", datatype)
                if not datatype:
                    raise TypeError("unknown datatype")

                # special case for array parts, others are managed by cast_out
                if issubclass(datatype, Array) and (
                    apdu.propertyArrayIndex is not None
                ):
                    if apdu.propertyArrayIndex == 0:
                        value = apdu.propertyValue.cast_out(Unsigned)
                    else:
                        value = apdu.propertyValue.cast_out(datatype.subtype)
                else:
                    value = apdu.propertyValue.cast_out(datatype)
                if _debug:
                    BOPTESTBacnetClientTestApplication._debug("    - value: %r", value)

                sys.stdout.write(str(value) + " and target value: " + str(context_obj['target_value'])+'\n')
                sys.stdout.flush()
                if context_obj['phase'] == 'first_read':
                    if isclose(value, context_obj['target_value'], abs_tol=0.001):
                        BOPTESTBacnetClientTestApplication._exception("exception: current value already matches target value\n")
                        stop()
                        return
                    deferred(self.issue_write_property, context_obj)
                if context_obj['phase'] == 'check-write':
                    if isclose(value, context_obj['target_value'], abs_tol=0.001):
                        sys.stdout.write("New value seen!\n")
                        stop()
                        return
                    else:
                        if context_obj['count'] < 10:
                            context_obj['count'] = context_obj['count'] + 1
                            task = FunctionTask(self.read_property, context_obj)
                            task.install_task(delta=2)
                        else:
                            BOPTESTBacnetClientTestApplication._exception("Error: value never converge\n")

            # do something with nothing?
            else:
                if _debug:
                    BOPTESTBacnetClientTestApplication._debug(
                        "    - ioError or ioResponse expected"
                    )
        except Exception as error:
            BOPTESTBacnetClientTestApplication._exception("exception: %r", error)

    def issue_write_property(self, context_obj):

        """write <addr> <objid> <prop> <value> [ <indx> ] [ <priority> ]"""

        addr = context_obj['addr']
        obj_id = context_obj['obj_id']
        prop_id = context_obj['prop_id']
        value = context_obj['target_value']
        try:

            obj_id = ObjectIdentifier(obj_id).value

            indx = None
            #if len(args) >= 5:
            #    if args[4] != "-":
            #        indx = int(args[4])
            #if _debug: BOPTESTBacnetClientTestApplication._debug("    - indx: %r", indx)

            priority = None
            #if len(args) >= 6:
            #    priority = int(args[5])
            #if _debug: BOPTESTBacnetClientTestApplication._debug("    - priority: %r", priority)

            # get the datatype
            datatype = get_datatype(obj_id[0], prop_id)
            if _debug: BOPTESTBacnetClientTestApplication._debug("    - datatype: %r", datatype)

            # change atomic values into something encodeable, null is a special case
            if (value == 'null'):
                value = Null()
            elif issubclass(datatype, AnyAtomic):
                dtype, dvalue = value.split(':', 1)
                if _debug: BOPTESTBacnetClientTestApplication._debug("    - dtype, dvalue: %r, %r", dtype, dvalue)

                datatype = {
                    'b': Boolean,
                    'u': lambda x: Unsigned(int(x)),
                    'i': lambda x: Integer(int(x)),
                    'r': lambda x: Real(float(x)),
                    'd': lambda x: Double(float(x)),
                    'o': OctetString,
                    'c': CharacterString,
                    'bs': BitString,
                    'date': Date,
                    'time': Time,
                    'id': ObjectIdentifier,
                    }[dtype]
                if _debug: BOPTESTBacnetClientTestApplication._debug("    - datatype: %r", datatype)

                value = datatype(dvalue)
                if _debug: BOPTESTBacnetClientTestApplication._debug("    - value: %r", value)

            elif issubclass(datatype, Atomic):
                if datatype is Integer:
                    value = int(value)
                elif datatype is Real:
                    value = float(value)
                elif datatype is Unsigned:
                    value = int(value)
                value = datatype(value)
            elif issubclass(datatype, Array) and (indx is not None):
                if indx == 0:
                    value = Integer(value)
                elif issubclass(datatype.subtype, Atomic):
                    value = datatype.subtype(value)
                elif not isinstance(value, datatype.subtype):
                    raise TypeError("invalid result datatype, expecting %s" % (datatype.subtype.__name__,))
            elif not isinstance(value, datatype):
                raise TypeError("invalid result datatype, expecting %s" % (datatype.__name__,))
            if _debug: BOPTESTBacnetClientTestApplication._debug("    - encodeable value: %r %s", value, type(value))

            # build a request
            request = WritePropertyRequest(
                objectIdentifier=obj_id,
                propertyIdentifier=prop_id
                )
            request.pduDestination = Address(addr)

            # save the value
            request.propertyValue = Any()
            try:
                request.propertyValue.cast_in(value)
            except Exception as error:
                BOPTESTBacnetClientTestApplication._exception("WriteProperty cast error: %r", error)

            # optional array index
            if indx is not None:
                request.propertyArrayIndex = indx

            # optional priority
            if priority is not None:
                request.priority = priority

            if _debug: BOPTESTBacnetClientTestApplication._debug("    - request: %r", request)

            # make an IOCB
            iocb = IOCB(request)
            if _debug: BOPTESTBacnetClientTestApplication._debug("    - iocb: %r", iocb)

            context_obj['phase'] = 'check-write'
            context_obj['count'] = 0
            iocb.add_callback(self.complete_write_property_request, context_obj)
            this_application.request_io(iocb)

        except Exception as error:
            BOPTESTBacnetClientTestApplication._exception("exception: %r", error)

    def complete_write_property_request(self, iocb, context_obj):
        # do something for success
        if iocb.ioResponse:
            # should be an ack
            if not isinstance(iocb.ioResponse, SimpleAckPDU):
                if _debug: BOPTESTBacnetClientTestApplication._debug("    - not an ack")
                return

            sys.stdout.write("ack from write\n")

        # do something for error/reject/abort
        if iocb.ioError:
            sys.stdout.write(str(iocb.ioError) + '\n')

        task = FunctionTask(self.read_property, context_obj)
        task.install_task(delta=1)



#
#   __main__
#
# python3 SimpleReadWrite.py 192.168.86.53:5000 analogOutput:33 presentValue  292
# for bestest_air that's con_oveTSetHea_u

def main():
    global this_device
    global this_application

    # parse the command line arguments
    parser = ConfigArgumentParser(description=__doc__)


    # add an argument for the address of the device
    parser.add_argument('device_addr', type=str,
          help='device address',
          )
    parser.add_argument('object_id',
          help='object identifier',
          )

    parser.add_argument('property_id', type=str,
          help='property type identifier',
          )

    parser.add_argument('target_value', type=str,
          help='the value to set and watch for',
          )

    # parse the args
    args = parser.parse_args()

    if _debug: _log.debug("initialization")
    if _debug: _log.debug("    - args: %r", args)

    # make a device object
    this_device = LocalDeviceObject(ini=args.ini)
    if _debug: _log.debug("    - this_device: %r", this_device)

    # make a simple application
    this_application = BOPTESTBacnetClientTestApplication(this_device, args.ini.address)

    enable_sleeping()
    context_obj = {"phase": "first_read", "target_value": float(args.target_value), "addr": args.device_addr, "obj_id": args.object_id, "prop_id": args.property_id}
    # kick off the process after the core is up and running
    deferred(this_application.read_property, context_obj)

    _log.debug("running")

    run()

    _log.debug("fini")

if __name__ == "__main__":
    main()
