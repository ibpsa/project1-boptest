import logging
import os


class ModelLogger:
    """A logger specific for the tasks of the ModelAdvancer"""

    def __init__(self):
        logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
        self.logger = logging.getLogger('simulation')
        self.formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        self.fh = logging.FileHandler('model_logger.log')
        self.fh.setFormatter(self.formatter)
        self.logger.addHandler(self.fh)
