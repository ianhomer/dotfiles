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
            "^([^:]*):" +                        # File part
            "(?:- \\[ \\] )?" +                  # Optional markdown part
            "((?:[A-Z]{3}(?=\\s))?)\\s*" +       # Context part
            "((?:[0-9]+(?=\\s)\\s)?)\\s*" +      # Date part
            "((?:[0-9]{4}(?=\\s)\\s)?)\\s*" + # Time part
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
            date = HumanDate(self.dateAsNumbers, self.days)
            self.date = date.display
            self.dateInclude = date.include
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
                self.end = HumanDate(match.group(1), self.days).display
                self.subject = match.group(2)
        else:
            self.file = None
            self.context = None
            self.date = None
            self.subject = None
