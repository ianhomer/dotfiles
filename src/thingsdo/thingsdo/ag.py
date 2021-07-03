class Ag:
    def __init__(self, path, justArchive=False, withArchive=False):
        self.path = path
        self.justArchive = justArchive
        self.withArchive = withArchive

    def parts(self, pattern, options):
        return ["ag"] + options + [pattern, self.path]
