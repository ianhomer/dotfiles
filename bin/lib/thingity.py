import configparser
import subprocess
import re
import time
from pathlib import Path
from datetime import datetime
from datetime import date
from . import runner

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
        subprocess.run(["tmux", "split-window", "-d", "-l", "5", "-v", "things -ms"])
    return force


def getTodayLog(now=datetime.now()):
    today = now.strftime("%m%d")
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{today}.md"


def getPath(name):
    return f"{THINGS_DIR}/{MY_NOTES}/stream/{name}.md"


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display date is None if date is "days" days into the future.
def getDateDisplay(dateAsNumbers, days):
    include = True
    if dateAsNumbers == "":
        return ("", None)
    if dateAsNumbers == "0 ":
        return ("*** ", 0)
    else:
        d1 = date.today()
        doDateMatch = re.search("^([0-9]{4})([0-9]{2}) $", dateAsNumbers)
        if doDateMatch:
            d0 = date(int(doDateMatch.group(1)), int(doDateMatch.group(2)), 1)
            daysToDate = (d0 - d1).days
            include = daysToDate <= days
            dateDisplay = d0.strftime("%b ").upper()
        else:
            doDateMatch = re.search("([0-9]{4})([0-9]{2})([0-9]{2})", dateAsNumbers)
            if doDateMatch:
                d0 = date(
                    int(doDateMatch.group(1)),
                    int(doDateMatch.group(2)),
                    int(doDateMatch.group(3) or 1),
                )
                daysToDate = (d0 - d1).days
                if daysToDate < 0:
                    dateDisplay = "*** "
                elif daysToDate <= 7:
                    dateDisplay = d0.strftime("%a ").upper()
                else:
                    dateDisplay = d0.strftime("%d %b ").upper()
            else:
                d0 = d1
                dateDisplay = dateAsNumbers
                daysToDate = (d0 - d1).days
                include = (d0 - d1).days <= days
    if include:
        return (dateDisplay, daysToDate)
    else:
        return (None, None)
