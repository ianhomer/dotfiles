#
# Convert a date in numbers, e.g. 202210602, to a human date relative to today
#

import datetime
import re
from datetime import date


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display is None if date is "days" days into the future.
class Date:
    def __init__(self, numbers, days=0, today: date = date.today()):
        self.days = days
        self.numbers = numbers
        self.today = today
        self._parse()

    def _parse(self):
        if match := re.search("^([0-9])$", self.numbers):
            self._parseRelativeDay(int(match.group(1)))
        elif match := re.search("^([0-9]{4})([0-9]{2}) $", self.numbers):
            thisDate = date(int(match.group(1)), int(match.group(2)), 1)
            self.daysAhead = (thisDate - self.today).days
            self.include = self.daysAhead <= self.days
            self.display = thisDate.strftime("%b ").upper()
        elif match := re.search("([0-9]{4})([0-9]{2})([0-9]{2})", self.numbers):
            thisDate = date(
                int(match.group(1)),
                int(match.group(2)),
                int(match.group(3) or 1),
            )
            self.daysAhead = (thisDate - self.today).days
            if self.daysAhead < 0:
                self.display = "***"
            elif self.daysAhead <= 7:
                self.display = thisDate.strftime("%a ").upper()
            elif self.daysAhead < 300:
                self.display = thisDate.strftime("%d %b ").upper()
            else:
                self.display = self.numbers
        else:
            self.display = self.numbers
            self.daysAhead = 0
            self.include = False

    def _parseRelativeDay(self, day):
        if day > 1:
            # 2 is mañana
            self.display = (
                (self.today + datetime.timedelta(days=1)).strftime("%a ").upper()
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
