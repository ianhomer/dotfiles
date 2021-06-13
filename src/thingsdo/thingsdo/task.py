#
# Parse a task line. See test cases for examples
#
import re
from . import HumanDate, HumanTime, Palette
from datetime import date


class Task:
    def __init__(self, line, days=7, defaultContext=None, today: date =
            date.today(), theme=None):
        self.line = line
        self.dateInclude = False
        self.timeInclude = True
        self.end = None
        self.days = days
        self.defaultContext = defaultContext
        self.today = today
        self.palette = Palette(theme=theme)
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
            self.context = match.group(2) or self.defaultContext
            self.dateIn = match.group(3) or None
            if self.dateIn is None:
                self.date = None
            else:
                self.date = HumanDate(self.dateIn, self.days, today=self.today)
                self.dateInclude = True
            self.timeAsNumbers = match.group(4) or None
            if self.timeAsNumbers is None:
                self.time = None
                self.timeInclude = False
            else:
                self.time = HumanTime(self.timeAsNumbers)
                self.timeInclude = self.time.include
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
                self.end = HumanDate(match.group(1), self.days, today=self.today)
                self.subject = match.group(2)
        else:
            self.file = None
            self.context = None
            self.date = None
            self.subject = None

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
        clear = self.palette.color("clear")
        parts = []
        if self.dateInclude:
            parts += [f"{self.palette.color('date')}{self.date.display} {clear}"]
        if self.timeInclude:
            parts += [f"{self.palette.color('time')}{self.time.display} {clear}"]
        if self.mission:
            parts += [self.palette.color("mission")]
        elif self.garage:
            parts += [self.palette.color("garage")]
        if self.end:
            parts += [f"to {self.palette.color('end')}{self.end.display}{clear}"]
        parts += [self.subject]

        return "".join(parts)

    @property
    def row(self):
        clear = self.palette.color("clear")
        separator = self.palette.color("separator")
        parts = []
        parts += [
            f"{self.rank}{separator}",
            f"{self.palette.color('context')}{self.context}{clear}{separator}",
            self.display,
            f"{separator}{self.file}"
        ]
        return "".join(parts)


    @property
    def rank(self):
        return (
            "2000" + (self.dateIn.strip() or "0")
            if self.date is not None and self.date.include
            else "3000"
        )
