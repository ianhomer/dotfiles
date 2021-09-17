import subprocess
import os


class GitFile:
    def __init__(self, base: str, path="", cmd=["git", "rev-parse", "--show-toplevel"]):
        fullPath = base + "/" + path
        directory = os.path.dirname(base + "/" + path)
        kwargs = {}
        # No need to change directory if just echo which is done from unit test
        # when mock command is injected
        if cmd[0] != "echo":
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
