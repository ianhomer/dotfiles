import re
from datetime import date


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
        if self.path == "stream":
            match = re.search("([0-9]{2})([0-9]{2})", self.base)
            if match:
                date = today.replace(
                    today.year, int(match.group(1)), int(match.group(2))
                )
                if date > today:
                    date = date.replace(date.year - 1)
                self.normalPath = "stream/archive/" + str(date.year)
                self.normalBase = date.strftime("%Y%m%d")

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
