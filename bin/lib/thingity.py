import configparser
from pathlib import Path
from datetime import datetime
from datetime import date
import re

config = configparser.ConfigParser()
config.read(str(Path.home()) + "/.config/dotme/shim.ini")
THINGS_DIR = config["DEFAULT"]["THINGS_DIR"]
MY_NOTES = config["DEFAULT"]["MY_NOTES"]


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
        return ""
    else:
        d1 = date.today()
        doDateMatch = re.search("^([0-9]{4})([0-9]{2}) $", dateAsNumbers)
        if doDateMatch:
            d0 = date(int(doDateMatch.group(1)), int(doDateMatch.group(2)), 1)
            include = (d0 - d1).days <= days
            dateDisplay = d0.strftime("%b ").upper()
        else:
            doDateMatch = re.search("([0-9]{4})([0-9]{2})([0-9]{2})", dateAsNumbers)
            if doDateMatch:
                d0 = date(
                    int(doDateMatch.group(1)),
                    int(doDateMatch.group(2)),
                    int(doDateMatch.group(3) or 1),
                )
                if (d0 - d1).days < 0:
                    dateDisplay = "*** "
                elif (d0 - d1).days <= 7:
                    dateDisplay = d0.strftime("%a ").upper()
                else:
                    dateDisplay = d0.strftime("%d %b ").upper()
            else:
                d0 = d1
                dateDisplay = dateAsNumbers
                include = (d0 - d1).days <= days
    if include:
        return dateDisplay
    else:
        return None
