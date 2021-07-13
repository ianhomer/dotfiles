import configparser
import datetime
import glob
import subprocess
import time
from pathlib import Path
from . import runner, Thing

config = configparser.ConfigParser()
config.read(str(Path.home()) + "/.config/dotme/shim.ini")
THINGS_DIR = config["DEFAULT"]["THINGS_DIR"]
MY_NOTES = config["DEFAULT"]["MY_NOTES"]
MY_NOTES_DIR = THINGS_DIR + "/" + MY_NOTES
shouldSynkFile = str(Path.home()) + "/.config/dotme/should-run/last-run-git-synk-things"


def synk(force, justMyNotes=False):
    if not force and not runner.should(shouldSynkFile):
        return
    if force:
        dir = MY_NOTES_DIR if justMyNotes else THINGS_DIR
        subprocess.run(["git", "synk"], cwd=dir)
        runner.has(shouldSynkFile)
        time.sleep(1)
    else:
        subprocess.run(
            ["tmux", "split-window", "-d", "-l", "1", "-v", "things --synk -m"]
        )
    return force


def getTodayLog(now=datetime.datetime.now()):
    today = now.strftime("%m%d")
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{today}.md"


def getPath(name):
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{name}.md"


def lint():
    errors = []
    for filename in glob.iglob(f"{THINGS_DIR}/**/*.md", recursive=True):
        try:
            thing = Thing(filename, root=THINGS_DIR)
            print(f"Linting : {thing.filename}")
            print(f"Normal : {thing.normal}")
            if not thing.normal:
                print(f"-> normal : {thing.normalFilename}")
        except Exception as exception:
            errors += [exception]

    for error in errors:
        print(f"ERROR : {error}")
