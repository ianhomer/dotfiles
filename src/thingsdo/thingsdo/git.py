import subprocess
import os


class Git:
    def __init__(self, base: str, path=""):
        self._root = (
            subprocess.Popen(
                ["git", "rev-parse", "--show-toplevel"],
                stdout=subprocess.PIPE,
                cwd=os.path.dirname(base + "/" + path),
            )
            .communicate()[0]
            .rstrip()
            .decode("utf-8")
        )

    @property
    def root(self):
        return self._root
