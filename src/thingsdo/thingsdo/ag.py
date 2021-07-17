from . import Environment


class Ag:
    def __init__(self, environment: Environment, justArchive=False, withArchive=False):
        self.path = environment.directory
        self.archiveParts = self.createArchiveParts(justArchive, withArchive)

    def createArchiveParts(self, justArchive, withArchive):
        if justArchive:
            return ["--file-search-regex", "\\/archive\\/"]
        elif withArchive:
            return []
        else:
            return ["--ignore-dir", "archive"]

    def parts(self, pattern, options):
        return ["ag"] + options + self.archiveParts + [pattern, self.path]
