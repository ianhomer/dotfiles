#
# Convert a date in numbers, e.g. 202210602, to a human date relative to today
#

import datetime
import re
from datetime import date


class Date:
    def __init__(self, numbers, today=date.today):
        self.numbers = numbers
        self.today = today
        self._parse()

    def _parse(self):
        if match := re.search("^([0-9])$", self.numbers):
            self._parseRelativeDay(int(match.group(1)))

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
