import os
import datetime
import time
from pathlib import Path


def should(file):
    if not os.path.isfile(file):
        return True
    lastRunTime = round(os.stat(file).st_mtime)
    shouldRunTime = round(
        time.mktime(
            (datetime.datetime.today() - datetime.timedelta(minutes=10)).timetuple()
        )
    )
    return lastRunTime < shouldRunTime


def has(file):
    Path(file).touch()
