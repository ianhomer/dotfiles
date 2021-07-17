import configparser
from pathlib import Path


class Environment:
    def __init__(self, directory=None):
        if directory:
            self.directory = directory
        else:
            config = configparser.ConfigParser()
            config.read(str(Path.home()) + "/.config/dotme/shim.ini")
            self.directory = config["DEFAULT"]["THINGS_DIR"]
