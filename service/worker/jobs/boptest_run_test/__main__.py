import json
import sys
from .job import Job

parameters = json.loads(sys.argv[1])
j = Job(parameters)
j.run()
