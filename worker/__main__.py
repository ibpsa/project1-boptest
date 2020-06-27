print("Starting Alfalfa Worker")

import sys
from .worker import Worker

if __name__ == '__main__':
    worker = Worker()
    worker.worker_logger.logger.info("Worker initialized")
    worker.run()  # run the alfalfa_worker

