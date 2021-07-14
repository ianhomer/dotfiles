from io import DEFAULT_BUFFER_SIZE
import os
import re
from datetime import date, timedelta


class Thing:
    def __init__(self, filename: str, root: str = None, today: date = date.today()):
        self.root = root
        self.filename = (
            filename
            if not self.root
            else filename[len(self.root) + 1 :]
            if filename.startswith(self.root)
            else filename
        )
        match = re.search("([^\\/]*)/(.*)/([^\\/]*).md", self.filename)
        if match:
            self.collection = match.group(1)
            self.path = match.group(2)
            self.base = match.group(3)
        else:
            match = re.search("([^\\/]*)/([^\\/]*).md", self.filename)
            if match:
                self.collection = match.group(1)
                self.base = match.group(2)
                self.path = None
            else:
                raise Exception(f"Not thing {self.filename}")

        self.normalBase = self.base
        self.normalPath = self.path
        if self.path and self.path.startswith("stream"):
            match = re.search("^([0-9]{2})([0-9]{2})$", self.base)
            if match:
                date = today.replace(
                    today.year, int(match.group(1)), int(match.group(2))
                )
                match = re.search("(20[0-9]{2})", self.path)
                if match:
                    # Year comes from archive path
                    date = date.replace(int(match.group(1)))
                elif date > today:
                    # Last year thin
                    date = date.replace(date.year - 1)
                if today - timedelta(days=40) > date:
                    self.normalPath = "stream/archive/" + str(date.year)
                    self.normalBase = date.strftime("%Y%m%d")

    def normalise(self):
        if self.root:
            destination = self.root + "/" + self.normalFilename
            destinationDirectory = os.path.dirname(destination)
            if not os.path.exists(destinationDirectory):
                print(f"Creating directory : {destinationDirectory}")
                os.makedirs(destinationDirectory)
            print(f"Moving : {self.filename} -> {self.normalFilename}")
            os.rename(
                self.root + "/" + self.filename, destination
            )

    @property
    def normal(self):
        return self.filename == self.normalFilename

    @property
    def normalFilename(self):
        return (
            self.collection
            + "/"
            + ((self.normalPath + "/") if self.normalPath else "")
            + self.normalBase
            + ".md"
        )
