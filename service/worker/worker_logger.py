########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import logging
import os


class WorkerLogger:
    """A logger specific for the tasks of the Worker"""

    def __init__(self):
        logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
        self.logger = logging.getLogger('alfalfa_worker')
        self.formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

        self.fh = logging.FileHandler('alfalfa_worker.log')
        self.fh.setFormatter(self.formatter)
        self.logger.addHandler(self.fh)

        self.ch = logging.StreamHandler()
        self.ch.setFormatter(self.formatter)
        self.logger.addHandler(self.ch)
