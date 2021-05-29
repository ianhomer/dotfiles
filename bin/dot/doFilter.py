#
# DoFilter is a string that defines local do filters. It is semi colon separated
# with each part indicating filters for a given context. The first part is the
# default context. The other parts are a colon separate string where the first
# part is a context name and the second part is comma separated list of contexts
# that you be included in filter when the context named in the first part is
# requested.
#
# For example
#   -A1,-A2;B:C,D;E:F,G
#
class DoFilter:
    def __init__(self, value):
        self.value = value
        parts = value.split(":")
        self.localPart = parts[0]

    def excludes(self):
        excludes = []
        for category in self.localPart.split(","):
            if category.startswith("-"):
                excludes.append(category[1:])
        return excludes
