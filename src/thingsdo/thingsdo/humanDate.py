#
# Convert a date in numbers, e.g. 202210602, to a human date relative to today
#

import datetime
import re
from datetime import date, timedelta


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display is None if date is "days" days into the future.
class HumanDate:
    def __init__(self, input, days=7, today: date = date.today()):
        self.days = days
        self.today = today
        self.daysAhead = 0
        self.include = False
        if input is None:
            self.display = None
        else:
            self.input = input.strip()
            self._parse()

    def _parse(self):
        if match := re.search("^([0-9])$", self.input):
            self._parseRelativeDay(int(match.group(1)))
            self.include = True
        elif match := re.search("^([A-Z]{3})$", self.input):
            self._parseDay(match.group(1))
            self.include = True
        elif match := re.search("^([0-9]{4})([0-9]{2}) $", self.input):
            thisDate = date(int(match.group(1)), int(match.group(2)), 1)
            self.daysAhead = (thisDate - self.today).days
            self.include = self.daysAhead <= self.days
            self.display = thisDate.strftime("%b").upper()
        elif match := re.search("([0-9]{4})([0-9]{2})([0-9]{2})", self.input):
            thisDate = date(
                int(match.group(1)),
                int(match.group(2)),
                int(match.group(3) or 1),
            )
            self.daysAhead = (thisDate - self.today).days
            self.include = True
            if self.daysAhead < 0:
                self.display = "***"
            elif self.daysAhead <= 7:
                self.display = thisDate.strftime("%a").upper()
            elif self.daysAhead < 300:
                self.display = thisDate.strftime("%d %b").upper()
            else:
                self.display = thisDate.strftime("%d %b %Y").upper()
        else:
            self.display = self.numbers

    def _parseRelativeDay(self, day):
        if day > 1:
            # 2 is mañana
            self.display = (
                (self.today + datetime.timedelta(days=1)).strftime("%a").upper()
            )
            self.daysAhead = 2
        elif day > 0:
            # 1 is today
            self.display = self.today.strftime("%a ").upper()
            self.daysAhead = 1
        else:
            # 0 is now
            self.display = "***"
            self.daysAhead = 0

    def _parseDay(self, day):
        for i in range(0, 7):
            candidate = self.today + timedelta(days=i)
            if (candidate).strftime("%a").upper() == day:
                self.date = candidate
                self.display = candidate.strftime("%a").upper()
                return candidate
        raise(Exception(f"Cannot find day {day}"))

    def asNumbers(self):
        return self.date.strftime("%Y%m%d")
