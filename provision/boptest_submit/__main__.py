from .boptest_submit import BoptestSubmit
import sys


client = BoptestSubmit()
client.submit_all(sys.argv[1])
