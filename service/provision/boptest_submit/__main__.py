from .boptest_submit import BoptestSubmit
import sys
import os


client = BoptestSubmit()
if sys.argv[1] == 'dashboard':
    client.submit_to_dashboard()
else:
    client.submit_all(sys.argv[1])
