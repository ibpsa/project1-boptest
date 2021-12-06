# -*- coding: utf-8 -*-
"""
This file is used by unit testing to specify library versions.
Commands here should maintain alignment with the environment generated in
testing/Dockerfile. The testcase name should be passed as an argument
when running this file.

"""

import json
import sys
import os

# Read library versions from testcase library_versions.json file
with open(os.path.join(sys.argv[1],'models','library_versions.json'),'r') as f:
    library_versions = json.loads(f.read())

# Checkout specified commit for each library
for key in library_versions.keys():
    if key == "IBPSA_COMMIT":
        os.system('cd $MODELICAPATH/IBPSA && git checkout "{}"'.format(library_versions[key]))
    elif key == "BUILDINGS_COMMIT":
        os.system('cd $MODELICAPATH/Buildings && git checkout "{}"'.format(library_versions[key]))
    elif key == "IDEAS_COMMIT":
        os.system('cd $MODELICAPATH/IDEAS && git checkout "{}"'.format(library_versions[key]))
    else:
        raise ReferenceError('Unknown key {} in library_versions.json file'\
                             'Allowed keys are: IBPSA_COMMIT, BUILDINGS_COMMIT, and IDEAS_COMMIT'.format(key))
