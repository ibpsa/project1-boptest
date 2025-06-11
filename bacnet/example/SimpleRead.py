#!/usr/bin/env python

"""
This application takes an address, an object id, and a property, 
then it reads it.

This code is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

"""

import json
from bacpypes.debugging import bacpypes_debugging, ModuleLogger
from bacpypes.consolelogging import ConfigArgumentParser

from bacpypes.core import run, deferred, stop, enable_sleeping
from bacpypes.iocb import IOCB

from bacpypes.primitivedata import Unsigned, ObjectIdentifier
from bacpypes.constructeddata import Array

from bacpypes.pdu import Address
from bacpypes.apdu import ReadPropertyRequest, ReadPropertyACK

from bacpypes.app import BIPSimpleApplication
from bacpypes.local.device import LocalDeviceObject
from bacpypes.object import get_datatype

_debug = 0
_log = ModuleLogger(globals())

# globals
this_device = None
this_application = None

#
# control flow:
# 1. main starts an event loop and registers a callback for read_property() to kick off right away
# 2. read_property gets called and issues a read request for requested property, and sets a callback for complete_read_property_request and passes the context obj to the callback
# 3. complete_read_property_request wakes up when the ack for the network request is received and prints the current value as json dump

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
                
                
                result = {'var': context_obj["obj_id"], 'value': value }
                print(json.dumps(result))  # Output as JSON
                
                stop()
            else:
                if _debug:
                    BOPTESTBacnetClientTestApplication._debug(
                        "    - ioError or ioResponse expected"
                    )
        except Exception as error:
            BOPTESTBacnetClientTestApplication._exception("exception: %r", error)

#
#   __main__
#
# python3 SimpleRead.py 192.168.86.53:5000 analogOutput:34 presentValue
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
    context_obj = {"addr": args.device_addr, "obj_id": args.object_id, "prop_id": args.property_id}
    deferred(this_application.read_property, context_obj)

    _log.debug("running")

    run()

    _log.debug("fini")

if __name__ == "__main__":
    main()
