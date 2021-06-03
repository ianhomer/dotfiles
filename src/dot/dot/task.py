#
# Parse a task line. See test cases for examples
#
import re
from . import Date


class Task:
    def __init__(self, line):
        self.line = line
        self._parse()

    def _parse(self):
        match = re.search(
            "^([^:]*):" +                        # File part
            "(?:- \\[ \\])?" +                   # Optional markdown part
            "((?:[A-Z]{3}(?=\\s))?)\\s*" +       # Context part
            "((?:[0-9]+(?=\\s)\\s)?)\\s*" +      # Date part
            "(.*)$",                             # Subject part
            self.line,
        )
        self.mission = False
        self.garage = False
        self.toDate = None
        if match:
            self.file = match.group(1)
            self.context = match.group(2)
            self.dateAsNumbers = match.group(3) or None
            self.date = Date(self.dateAsNumbers).display
            subject = match.group(4)
            first = subject[:1]
            if first == "~":
                self.mission = True
                self.subject = subject[1:].strip()
            elif first == ".":
                self.garage = True
                self.subject = subject[1:].strip()
            else:
                self.subject = subject
            # Extra toDate part
            match = re.search("to ([0-9]{8}) (.*)", subject)
            if match:
                self.end = Date(match.group(1)).display
                self.subject = match.group(2)
        else:
            self.file = None
            self.context = None
            self.date = None
            self.subect = self.line
