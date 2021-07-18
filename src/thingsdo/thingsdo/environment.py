import configparser
import os
from pathlib import Path


class Environment:
    def __init__(self, directory=None, configFile="~/.config/thingsdo/thingsdo.ini"):
        self.home = str(Path.home())
        if directory:
            self.directory = directory
            self.confg = {}
        elif configFile:
            config = configparser.ConfigParser()
            config.read(configFile.replace("~", self.home))
            self.config = config["DEFAULT"]
            self.directory = self.config["THINGS_DIR"]
        else:
            self.directory = os.getcwd()
            self.config = {}
