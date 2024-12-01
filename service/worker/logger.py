########################################################################################################################

# -*- coding: utf-8 -*-
from __future__ import print_function

import logging
import os


class Logger:
    """A logger specific for the tasks of the Worker"""

    def __init__(self):
        self.logger = logging.getLogger('worker')
        self.logger.setLevel(os.environ.get("BOPTEST_LOGLEVEL", "INFO"))
        fmt = '%(asctime)s UTC\t%(name)-20s%(levelname)s\t%(message)s'
        datefmt = '%m/%d/%Y %I:%M:%S %p'
        formatter = logging.Formatter(fmt,datefmt)

        stream_handler = logging.StreamHandler()
        stream_handler.setFormatter(formatter)
        self.logger.addHandler(stream_handler)
