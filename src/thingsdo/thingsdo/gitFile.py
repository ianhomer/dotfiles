import subprocess
import os


class GitFile:
    def __init__(self, base: str, path="", cmd=["git", "rev-parse", "--show-toplevel"]):
        fullPath = base + "/" + path
        directory = os.path.dirname(base + "/" + path)
        kwargs = {}
        if cmd[0] == "git":
            kwargs["cwd"] = directory

        self._root = (
            subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True, **kwargs)
            .communicate()[0]
            .rstrip()
        )
        self._path = fullPath[len(self._root) + 1 :]

    @property
    def root(self):
        return self._root

    @property
    def path(self):
        return self._path
