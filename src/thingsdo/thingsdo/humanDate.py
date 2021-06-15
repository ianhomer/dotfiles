#
# Convert a date in numbers, e.g. 202210602, to a human date relative to today
#

import datetime
import re
from datetime import date, timedelta


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display is None if date is "days" days into the future.
class HumanDate:
    def __init__(self, input, today: date = date.today()):
        self.today = today
        self.daysAhead = 0
        if input is None:
            self.display = None
            self.daysAhead = 0
        else:
            self.input = input.strip()
            self._parse()

    def _parse(self):
        if match := re.search("^([0-9])$", self.input):
            self.date = self._parseRelativeDay(int(match.group(1)))
        elif match := re.search("^([A-Z]{3}\\s[0-9]+)$", self.input):
            self.date = self._parseDate(match.group(1))
        elif match := re.search("^([A-Z]{3})$", self.input):
            self.date = self._parseDay(match.group(1))
        elif match := re.search("^([0-9]{4})([0-9]{2}) $", self.input):
            self.date = date(int(match.group(1)), int(match.group(2)), 1)
        elif match := re.search("([0-9]{4})([0-9]{2})([0-9]{2})", self.input):
            self.date = date(
                int(match.group(1)),
                int(match.group(2)),
                int(match.group(3) or 1),
            )
        else:
            self.date = self.today

        self.daysAhead = (self.date - self.today).days
        if self.daysAhead < 0:
            self.display = "***"
        elif self.daysAhead <= 7:
            self.display = self.date.strftime("%a").upper()
        elif self.daysAhead < 300:
            self.display = self.date.strftime("%d %b").upper()
        else:
            self.display = self.date.strftime("%d %b %Y").upper()

    def _parseRelativeDay(self, day):
        return self.today + datetime.timedelta(days=day - 1)

    # Parse a day of the week like MON or TUE to a date based on what today is
    def _parseDay(self, day):
        for i in range(0, 7):
            candidate = self.today + timedelta(days=i)
            if candidate.strftime("%a").upper() == day:
                return candidate
        raise (Exception(f"Cannot find day {day}"))

    # Parse a date like JUN 8 by scanning forward for a year
    def _parseDate(self, date: str):
        needle = date.upper()
        for i in range(0, 365):
            candidate = self.today + timedelta(days=i)
            if candidate.strftime("%b %-d").upper() == needle:
                return candidate
            if candidate.strftime("%b %d").upper() == needle:
                return candidate
        raise (Exception(f"Cannot find date {date}"))

    @property
    def code(self):
        return self.date.strftime("%Y%m%d")

    def __str__(self):
        return self.display
