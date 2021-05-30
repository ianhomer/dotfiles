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
            self.context = match.group(2)
        else:
            self.context = None
