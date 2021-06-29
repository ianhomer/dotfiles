#
# Parse a task line. See test cases for examples
#
import re
from thingsdo.taskRenderer import TaskRenderer
from . import HumanDate, HumanTime
from datetime import date

NON_CATEGORIES = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN",
    "TOD",
    "TOM"
]

#
# When natural is true then line interpretted as entered by human.
#


class Task:
    def __init__(
        self,
        line,
        natural=False,
        # How many days are considered near
        near=3,
        defaultContext=None,
        today: date = date.today(),
    ):
        self.dateInclude = False
        self.near = near
        self.defaultContext = defaultContext
        self.end = None
        self.line = line
        self.natural = natural
        self.timeInclude = True
        self.today = today
        self._parse()

    def _parse(self):
        match = re.search(
            # File part
            ("()" if self.natural else "^([^:]*):") +
            # Optional markdown part
            "(?:- \\[ \\] )?" +
            # Context part
            "((?:[A-Z]{3}(?=\\s))?)\\s*" +
            # Date part
            "((?:(?:[0-9]+"
            + (
                "|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|MON|TUE|WED|THU|FRI|SAT|SUN|TOD|TOM)(?:\\s[0-9]{1,2})?"
                if self.natural
                else ""
            )
            + ")(?=\\s)\\s)?)\\s*"
            +
            # Time part
            "((?:[0-9]{2}:?[0-9]{2}(?=\\s)\\s)?)\\s*" +
            # Subject part
            "(.*)$",
            # Pre-pepend MEM category if natural and starts with a non-category,
            # e.g. day of week
            (
                "MEM "
                if (
                    self.natural
                    and (
                        (self.line[0:3] in NON_CATEGORIES)
                        or re.search("^[0-9]{2}:?[0-9]{2}", self.line[0:5])
                    )
                )
                else ""
            )
            + self.line,
        )
        self.mission = False
        self.garage = False
        self.toDate = None
        if match:
            self.file = match.group(1)
            self.context = match.group(2) or self.defaultContext
            self.dateIn = match.group(3) or None
            if self.dateIn is None:
                self.date = None
            else:
                self.date = HumanDate(self.dateIn, today=self.today)
                self.dateInclude = True
            self.timeAsNumbers = match.group(4) or None
            if self.timeAsNumbers is None:
                self.time = None
                self.timeInclude = False
            else:
                self.time = HumanTime(self.timeAsNumbers)
                self.timeInclude = self.time.include
                if self.date is None:
                    self.date = HumanDate(today = self.today)
                    self.dateInclude = True
            subject = match.group(5)
            first = subject[:1]
            if first == "~":
                self.mission = True
                self.subject = subject[1:].strip()
            elif first == ".":
                self.garage = True
                self.subject = subject[1:].strip()
            elif first == "-":
                self.garage = True
                self.subject = subject[1:].strip()
            else:
                self.subject = subject
            # Extra toDate part
            match = re.search("to ([0-9]{8}) (.*)", subject)
            if match:
                self.end = HumanDate(match.group(1), today=self.today)
                self.subject = match.group(2)
        else:
            self.file = None
            self.context = None
            self.date = None
            self.time = None
            self.subject = self.line

    def __str__(self):
        return self.code

    @property
    def code(self):
        parts = []
        if self.context:
            parts += [self.context]
        if self.date:
            parts += [self.date.code]
        if self.time and self.timeInclude:
            parts += [self.time.code]
        if self.end:
            parts += ["to", self.end.code]
        parts += [self.subject]
        return " ".join(parts)

    @property
    def display(self):
        return TaskRenderer().renderBody(self)

    @property
    def row(self):
        return TaskRenderer().render(self)

    @property
    def rankGroup(self):
        return (
            (2000 if self.date.daysAhead < self.near else 4000)
            if self.date is not None
            else (5000 if self.mission else 4000 if self.garage else 3000)
        )

    @property
    def rank(self):
        return (
            str(self.rankGroup) + self.date.code +
            (
                 self.time.code
                 if self.time is not None
                 else "0000"
             )
            if self.date is not None
            else str(self.rankGroup)
        )
