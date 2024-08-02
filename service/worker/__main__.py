print("Starting BOPTEST Worker")

import sys
from .worker import Worker

if __name__ == '__main__':
    worker = Worker()
    worker.run()
