#
# Convert a time in numbers, e.g. 1414, to a human time
#

import re
from datetime import date


# Given date as numbers, e.g. 20210531, output a nice human date from a todo
# point of view. Display is None if date is "days" days into the future.
class HumanTime:
    def __init__(self, input, today: date = date.today()):
        self.today = today
        if input is None:
            self.display = None
            self.include = False
            self.codified = None
        else:
            self.include = True
            self._parse(input.strip())

    def _parse(self, input: str):
        if match := re.search("^([0-9]{2}):?([0-9]{2})$", input):
            self.display = f"{match.group(1)}:{match.group(2)}"
            self.codified = f"{match.group(1)}{match.group(2)}"
        else:
            self.display = input
            self.codified = input

    @property
    def code(self):
        return self.codified

    def __str__(self):
        return self.display

