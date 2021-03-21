import configparser
from pathlib import Path
from datetime import datetime

config = configparser.ConfigParser()
config.read(str(Path.home()) + "/.config/dotme/shim.ini")
THINGS_DIR = config["DEFAULT"]["THINGS_DIR"]
MY_NOTES = config["DEFAULT"]["MY_NOTES"]


def getTodayLog(now=datetime.now()):
    today = now.strftime("%m%d")
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{today}.md"


def getPath(name):
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{name}.md"
