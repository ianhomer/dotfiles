import glob
import os
import subprocess
import time
from . import Environment, runner, Signal, Thing

environment = Environment()


def synk(force, justMyNotes=False):
    shouldSynkFile = (
        environment.home + "/.config/dotme/should-run/last-run-git-synk-things"
    )
    if not force and not runner.should(shouldSynkFile):
        return
    if force:
        dir = environment.myNotesDir if justMyNotes else environment.directory
        subprocess.run(["git", "synk"], cwd=dir)
        runner.has(shouldSynkFile)
        time.sleep(1)
    else:
        subprocess.run(
            ["tmux", "split-window", "-d", "-l", "1", "-v", "things --synk -m"]
        )
    return force


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
