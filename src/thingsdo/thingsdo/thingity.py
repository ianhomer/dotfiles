import datetime
import glob
import os
import subprocess
import time
from . import Environment, runner, Signal, Thing

environment = Environment()
MY_NOTES = environment.config["MY_NOTES"]
MY_NOTES_DIR = environment.directory + "/" + MY_NOTES
shouldSynkFile = environment.home + "/.config/dotme/should-run/last-run-git-synk-things"


def synk(force, justMyNotes=False):
    if not force and not runner.should(shouldSynkFile):
        return
    if force:
        dir = MY_NOTES_DIR if justMyNotes else environment.directory
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
    return f"{environment.directory}/{MY_NOTES}/stream/{today}.md"


def getPath(name):
    return f"{environment.directory}/{MY_NOTES}/stream/{name}.md"


def lint(fix=False):
    signals = []
    for filename in glob.iglob(f"{environment.directory}/**/*.md", recursive=True):
        try:
            thing = Thing(filename, root=environment.directory)
            if not thing.normal:
                thing.normalise(fix)
        except Exception as exception:
            signals += [Signal(exception=exception, context=filename)]

    for signal in signals:
        print(f"{signal}")

    # Show any todos in the archive, since these will be excluded
    # from the default todo execution.
    os.system("todo --justarchive --stream")
