import json
import os
import sys
import uuid

from pyfmi import load_fmu

# 1.0 setup the inputs
fmupath = sys.argv[1]
fmu_upload_name = sys.argv[2]
jsonpath = sys.argv[3]

fmu = load_fmu(fmupath)

# 2.0 get input/output variables from the FMU
input_names = fmu.get_model_variables(causality=2).keys()
output_names = fmu.get_model_variables(causality=3).keys()

# 3.0 add site tagging
tags = []

fmu_upload_name = os.path.basename(fmu_upload_name)  # without directories
fmu_upload_name = os.path.splitext(fmu_upload_name)[0]  # without extension

tmp = fmupath.split('/')
upload_id = tmp[2]

# siteid = uuid.uuid4() #old siteid
siteid = upload_id

sitetag = {
    "dis": "s:%s" % fmu_upload_name,
    "id": "r:%s" % siteid,
    "site": "m:",
    "datetime": "s:",
    "simStatus": "s:Stopped",
    "simType": "s:fmu",
    "siteRef": "r:%s" % siteid
}
tags.append(sitetag)

# 4.0 add input tagging
for var_input in input_names:
    if not var_input.endswith("_activate"):
        tag_input = {
            "id": "r:%s" % uuid.uuid4(),
            "dis": "s:%s" % var_input,
            "siteRef": "r:%s" % siteid,
            "point": "m:",
            "writable": "m:",
            "writeStatus": "s:disabled",
            "kind": "s:Number",
        }
        tags.append(tag_input)
        tag_input = {}

# 5.0 add output tagging
for var_output in output_names:
    tag_output = {
        "id": "r:%s" % uuid.uuid4(),
        "dis": "s:%s" % var_output,
        "siteRef": "r:%s" % siteid,
        "point": "m:",
        "cur": "m:",
        "curVal": "n:",
        "curStatus": "s:disabled",
        "kind": "s:Number",
    }
    tags.append(tag_output)
    tag_output = {}

# 6.0 write tags to the json file
with open(jsonpath, 'w') as outfile:
    json.dump(tags, outfile)
