import configparser
from pathlib import Path


class Environment:
    def __init__(self, directory=None):
        self.home = str(Path.home())
        if directory:
            self.directory = directory
            self.confg = {}
        else:
            config = configparser.ConfigParser()
            config.read(self.home + "/.config/thingsdo/thingsdo.ini")
            self.config = config["DEFAULT"]
            self.directory = self.config["THINGS_DIR"]
