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
        date = None
        postfix = ""
        if self.path and self.path.startswith("stream"):
            match = re.search("^[0-9]*([0-9]{2})([0-9]{2})(-.*)?$", self.base)
            if match:
                postfix = match.group(3) if match.group(3) else ""
                date = today.replace(
                    today.year, int(match.group(1)), int(match.group(2))
                )
                match = re.search("(20[0-9]{2})", self.path)
                if match:
                    # Year comes from archive path
                    date = date.replace(int(match.group(1)))
                elif date > today:
                    # Last year thing
                    date = date.replace(date.year - 1)

        if not self.path:
            match = re.search("^([0-9]{4})-([0-9]{2})-([0-9]{2})$", self.base)
            if match:
                date = today.replace(
                    int(match.group(1)), int(match.group(2)), int(match.group(3))

                )

        if date:
            if today - timedelta(days=40) > date:
                self.normalPath = "stream/archive/" + str(date.year)
                self.normalBase = date.strftime("%Y%m%d") + postfix

    def normalise(self, fix=False):
        mode = "+" if fix else "-"
        if self.root:
            # Safe guard on root to reduce risk of normalising files
            # outside of a things root
            if "projects/things" in self.root:
                destination = self.root + "/" + self.normalFilename
                destinationDirectory = os.path.dirname(destination)
                if not os.path.exists(destinationDirectory):
                    print(f"{mode} Create directory : {destinationDirectory}")
                    if fix:
                        os.makedirs(destinationDirectory)
                print(f"{mode} Move : {self.filename} -> {self.normalFilename}")
                if fix:
                    os.rename(self.root + "/" + self.filename, destination)
            else:
                raise Exception(f"Safe guard root {self.root} not a things root")
        else:
            raise Exception(f"Cannot normalise {self} since no root set")

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
