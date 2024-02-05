########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import logging
import os


class Logger:
    """A logger specific for the tasks of the Worker"""

    def __init__(self):
        logging.basicConfig(level=os.environ.get("BOPTEST_LOGLEVEL", "INFO"))
        self.logger = logging.getLogger('worker')
        self.formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

        self.fh = logging.FileHandler('worker.log')
        self.fh.setFormatter(self.formatter)
        self.logger.addHandler(self.fh)
