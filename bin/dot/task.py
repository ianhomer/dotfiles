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
        self.mission = False
        self.garage = False
        if match:
            self.file = match.group(1)
            self.context = match.group(2)
            self.date = match.group(3) or None
            subject = match.group(4)
            first = subject[:1]
            if first == "~":
                self.mission = True
                self.subject = subject[1:].strip()
            elif first == ".":
                self.garage = True
                self.subject = subject[1:].strip()
            else:
                self.subject = subject
        else:
            self.file = None
            self.context = None
            self.date = None
            self.subect = None
