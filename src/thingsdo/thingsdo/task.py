#
# Parse a task line. See test cases for examples
#
import re
from . import HumanDate, HumanTime


class Task:
    def __init__(self, line, days=7):
        self.line = line
        self.dateInclude = False
        self.timeInclude = True
        self.end = None
        self.days = days
        self._parse()

    def _parse(self):
        match = re.search(
            # File part
            "^([^:]*):" +
            # Optional markdown part
            "(?:- \\[ \\] )?" +
            # Context part
            "((?:[A-Z]{3}(?=\\s))?)\\s*" +
            # Date part
            "((?:(?:[0-9]+|[A-Z]{3})(?=\\s)\\s)?)\\s*" +
            # Time part
            "((?:[0-9]{4}(?=\\s)\\s)?)\\s*" +
            # Subject part
            "(.*)$",
            self.line,
        )
        self.mission = False
        self.garage = False
        self.toDate = None
        if match:
            self.file = match.group(1)
            self.context = match.group(2)
            self.dateIn = match.group(3) or None
            if self.dateIn is None:
                self.date = None
            else:
                self.date = HumanDate(self.dateIn, self.days)
            self.timeAsNumbers = match.group(4) or None
            time = HumanTime(self.timeAsNumbers)
            self.time = time.display
            self.timeInclude = time.include
            subject = match.group(5)
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
                self.end = HumanDate(match.group(1), self.days)
                self.subject = match.group(2)
        else:
            self.file = None
            self.context = None
            self.date = None
            self.subject = None

    @property
    def rank(self):
        return (
            "2000" + (self.dateIn.strip() or "0")
            if self.date is not None and self.date.include
            else "3000"
        )
