import re


class Thing:
    def __init__(self, filename: str, root: str = None):
        self.root = root
        self.filename = (
            filename
            if not root
            else filename[len(root) + 1 :]
            if filename.startswith(root)
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

    @property
    def normal(self):
        return self.filename == self.normalFilename

    @property
    def normalFilename(self):
        return self.filename
