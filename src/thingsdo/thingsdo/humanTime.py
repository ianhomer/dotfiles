#
# Convert a time in numbers, e.g. 1414, to a human time
#

import re
from datetime import date


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display is None if date is "days" days into the future.
class HumanTime:
    def __init__(self, numbers, today: date = date.today()):
        self.today = today
        if numbers is None:
            self.display = None
            self.include = False
        else:
            self.numbers = numbers.strip()
            self.include = True
            self._parse()

    def _parse(self):
        if match := re.search("^([0-9]{2})([0-9]{2})$", self.numbers):
            self.display = f"{match.group(1)}:{match.group(2)}"
        else:
            self.display = self.numbers

    @property
    def code(self):
        return self.numbers

    def __str__(self):
        return self.display

