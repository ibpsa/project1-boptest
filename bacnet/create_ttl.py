# -*- coding: utf-8 -*-
"""
Creates ttl file for creation of Brick objects.

To run this script:
1. Deploy BOPTEST as described in README.md at root of repository
2. Set 'test_case_name' parameter to test case that needs bacnet .ttl
   (i.e. bestest_air)
3. Run script
4. ''<test_case_name>.ttl'' file will be generated with inputs and measurement
   bacnet points

"""

import requests

# Set url for BOPTEST test case
baseurl = 'http://127.0.0.1:80'

# Instatiate test case
test_case_name = 'multizone_office_simple_hydronic'
testid = requests.post("{0}/testcases/{1}/select".format(baseurl, test_case_name)).json()["testid"]

# Write the file prefix
prefix = '@prefix bldg: <urn:example#> .\n\
@prefix brick: <https://brickschema.org/schema/Brick#> .\n\
@prefix bacnet: <http://data.ashrae.org/bacnet/2020#> .\n\
@prefix unit: <http://qudt.org/vocab/unit/> .\n\
@prefix owl: <http://www.w3.org/2002/07/owl#> .\n\
@prefix ref: <https://brickschema.org/schema/Brick/ref#> .\n\
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n\n\
<urn:example#> a owl:Ontology ;\n\
\towl:imports <https://brickschema.org/schema/1.2/Brick#> .\n\n\
bldg:boptest-proxy-device a bacnet:BACnetDevice ;\n\
\tbacnet:device-instance 599 .\n\n'

with open(test_case_name+'.ttl', 'w') as f:
    f.write(prefix)

# Get all the points and their metadata from BOPTEST test case
advance = {'advance':{'Description': 'Advance command', 'Minimum': 0, 'Maximum': None}}
time = {'time':{'Unit': 's', 'Description': 'Simulation time', 'Minimum': None, 'Maximum': None}}
measurement_points = requests.get('{0}/measurements/{1}'.format(baseurl,testid)).json()['payload']
input_points = requests.get('{0}/inputs/{1}'.format(baseurl,testid)).json()['payload']
points = advance | time | measurement_points | input_points

# Stop test case
requests.put('{0}/stop/{1}'.format(baseurl, testid))

# Write the bacnet objects for each point in the file
with open(test_case_name+'.ttl', 'a') as f:
    obj_id = 1
    for point in points:
        # Assign type
        if point[-2:] == '_y':
            obj_type = 'analog-input'
        elif point[-2:] == '_u' or point == 'advance':
            obj_type = 'analog-output'
        elif point[-9:] == '_activate':
            continue
        elif point == 'time':
            obj_type = 'analog-value'
        else:
            raise ValueError('{0} is not a valid point ending in _y or _u'.format(point))

        f.write('bldg:{0} a brick:Point ;\n'.format(point))
        f.write('\tref:hasExternalReference [\n')
        f.write('\t\tbacnet:object-identifier "{0},{1}" ;\n'.format(obj_type, obj_id))
        f.write('\t\tbacnet:object-type "{0}" ;\n'.format(obj_type))
        f.write('\t\tbacnet:object-name "{0}" ;\n'.format(point))
        f.write('\t\tbacnet:status-flags 0 ;\n')
        f.write('\t\tbacnet:objectOf bldg:boptest-proxy-device\n')
        f.write('\t] .\n\n')

        obj_id = obj_id + 1
