import subprocess
import sys
from subprocess import PIPE
from . import Environment
from typing import Optional


# Make a part safe for executing as shell command. This allows the output from a
# dry run report to be cut and pasted into a shell window
def commandPartShellSafe(part):
    if part.startswith("s/") or part.startswith("*") or part.startswith("^"):
        return f"'{part}'"
    return part


def shellSafe(parts):
    return map(commandPartShellSafe, parts)


class Search:
    def __init__(self, environment: Environment):
        self.environment = environment
        self.withModifiedKey = False
        self.sort = False
        self.maxPerFile = 0
        self.filter = "s/^/:/"
        self.matchPrefix = ""
        self.postFilter: Optional[str] = None
        self.filter: Optional[str] = None

    # Command to search for things
    def createCommand(self):
        return ["fd"]

    # Filter command to get output into desired 3 part format
    def createFilterCommand(self):
        if self.withModifiedKey:
            return ["things-with-modified"]
        elif self.filter is not None:
            return ["sed", self.filter]
        else:
            return []

    def createPostFilterCommand(self):
        if self.postFilter is not None:
            return ["sed", self.postFilter]
        else:
            return []

    def createSortCommand(self):
        if self.sort:
            return ["sort"]
        else:
            return []

    def run(self, args):
        command = self.createCommand()
        filterCommand = self.createFilterCommand()
        postFilterCommand = self.createPostFilterCommand()
        sortCommand = self.createSortCommand()

        if args.dry:
            command = " ".join(shellSafe(command))
            if len(filterCommand) > 0:
                command += " | " + " ".join(shellSafe(filterCommand))
            if len(postFilterCommand) > 0:
                command += " | " + " ".join(shellSafe(postFilterCommand))
            if len(sortCommand) > 0:
                command += " | " + " ".join(shellSafe(sortCommand))
            print(command)
            return
        pipe = subprocess.Popen(
            command, stdout=PIPE, cwd=self.environment.directory, text=True
        )
        pipeIn = pipe
        if len(filterCommand) > 0:
            pipe = subprocess.Popen(
                filterCommand,
                stdin=pipe.stdout,
                stdout=PIPE,
                text=True,
                cwd=self.environment.directory,
            )
        if len(postFilterCommand) > 0:
            pipe = subprocess.Popen(
                postFilterCommand,
                stdin=pipe.stdout,
                stdout=PIPE,
                text=True,
                cwd=self.environment.directory,
            )
        if len(sortCommand) > 0:
            pipe = subprocess.Popen(
                sortCommand,
                stdin=pipe.stdout,
                stdout=PIPE,
                text=True,
                cwd=self.environment.directory,
            )
        if pipe.stdout:
            for line in iter(pipe.stdout.readline, b""):
                sys.stdout.write(line)
                if not line:
                    if pipeIn.poll() is not None and pipe.poll() is not None:
                        break

            pipe.stdout.close()
