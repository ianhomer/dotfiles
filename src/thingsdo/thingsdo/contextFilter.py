#
# ContextFilter is a string that defines multiple filters
#
# (part0):(part):(part)
#
# Where
#
#   part0 = -A,-B => exclude A and B as default context
#   part = A>B,C => context A should also include B and C
#
# For example
#   -A1,-A2:B>C,D:E>F,G
#
# This string is a lightweight string that can be set in envrionment and drive
# defaults for the "do" command.
#
class ContextFilter:
    def __init__(self, value):
        self.value = value
        self.parts = value.split(":")
        self.localPart = self.parts[0]

    def excludes(self):
        excludes = []
        for category in self.localPart.split(","):
            if category.startswith("-"):
                excludes.append(category[1:])
        return excludes

    def children(self, parent):
        matcher = parent + ">"
        for part in self.parts:
            if part.startswith(matcher):
                return part[len(matcher):].split(",")
