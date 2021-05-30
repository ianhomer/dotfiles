#
# Parse a task line. See test cases for examples
#
import re


class Task:
    def __init__(self, line):
        self.line = line
        self._parse()

    def _parse(self):
        match = re.search(
            "^([^:]*):((?:[A-Z]{3}(?=\\s))?)\\s*((?:[0-9]+(?=\\s)\\s)?)\\s*(.*)$",
            self.line,
        )
        if match:
            self.file = match.group(1)
            self.context = match.group(2)
            self.date = match.group(3) or None
            self.subject = match.group(4)
        else:
            self.file = None
            self.context = None
            self.date = None
