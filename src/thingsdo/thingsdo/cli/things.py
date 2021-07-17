#!/usr/bin/env python3

import argparse
import os
import subprocess
import re
import shutil
from subprocess import PIPE
from thingsdo import Environment, thingity


THINGS_DIR = Environment().directory


def run():
    parser = argparse.ArgumentParser(description="things")
    parser.add_argument("thing", nargs="*", help="thing")
    parser.add_argument("--lint", action="store_true")
    parser.add_argument("--fix", action="store_true")
    parser.add_argument("--witharchive", action="store_true")
    parser.add_argument("--justarchive", action="store_true")
    parser.add_argument("-s", "--search", help="find things", action="store_true")
    parser.add_argument("-n", "--name", help="find things with named search")
    parser.add_argument("-r", "--recent", help="recent things", action="store_true")
    parser.add_argument("--synk", help="synk things", action="store_true")
    # Just sync my notes
    parser.add_argument("-m", "--my", help="synk my things", action="store_true")
    parser.add_argument("-o", "--open", help="open my things", action="store_true")

    args = parser.parse_args()

    if thingity.synk(args.synk, args.my):
        return

    if args.open:
        return open()

    if args.lint:
        return thingity.lint(fix=args.fix)

    more = True
    while more:
        if args.recent:
            more = recent(args)
        else:
            more = search(args)


def open():
    subprocess.run(["nvim"], env={**os.environ, "VIM_KNOB": "4"}, cwd=THINGS_DIR)


class Fzf:
    # Command Fzf command
    # Stream into fzf has three ":" separated parts
    # 1) sort key
    # 2) filename
    # 3) line number in file for preview
    # 4) display string
    def __init__(self):
        terminal = shutil.get_terminal_size((80, 24))
        self.cmd = [
            "fzf",
            "--multi",
            "--height",
            "100%",
            "--ansi",
            "--no-sort",
            "-d",
            ":",
            "--with-nth",
            "4..",
            "--color",
            "dark",
        ]
        if terminal.columns > 60 or terminal.lines > 10:
            if terminal.columns > 100:
                width = 120 if terminal.columns > 150 else int(terminal.columns * 0.6)
                self.cmd += [
                    "--preview-window",
                    f"right,{width}",
                ]
            else:
                width = terminal.columns
                height = "5" if terminal.lines < 20 else "50%"
                self.cmd += [
                    "--preview-window",
                    f"bottom,{height}",
                ]
            self.cmd += [
                "--preview",
                "cat (echo {} | cut -d: -f2) | cut -c 1-"
                + str(width - 2)
                + " | "
                + "bat --style=header --color=always "
                + "--file-name (echo {} | cut -d: -f2) "
                + "-l md "
                + "-r (echo {} | cut -d: -f3): ",
            ]
        self.parts = []
        self.defaultCommand = "true"
        self.filenameMatcher = "^[^:]*:([^:]*)"
        self.binds = [
            "ctrl-f:reload("
            + "fd --changed-within 3months md --exec stat -f '%m:%N:1:%N' {q} "
            + "| sort -r)",
            "ctrl-e:reload(things-search -n sort-modified {q} || true)",
            "ctrl-g:reload(things-search -n bookmarks {q} || true)",
            "ctrl-s:reload(things-search -n headings {q} || true)",
            # Note that ctrl-x aborts so that a subsequence ctrl-x in fish shell
            # opens cheats. Similarly for ctrl-w opening todos.
            "ctrl-x:abort",
            "ctrl-w:abort",
            "ctrl-o:execute(tmux split-window -v 'nvim {2}')"
        ]

    def run(self):
        cmd = self.cmd + self.parts
        if len(self.binds) > 0:
            cmd += ["--bind", ",".join(self.binds)]
        process = subprocess.run(
            cmd,
            stdout=PIPE,
            text=True,
            stderr=None,
            env={**os.environ, "FZF_DEFAULT_COMMAND": self.defaultCommand},
            cwd=THINGS_DIR,
        )
        lines = process.stdout.splitlines()
        selected = []
        for line in lines:
            match = re.search(self.filenameMatcher, line)
            if match:
                selected.append(match.group(1))

        if len(selected) > 0:
            subprocess.call(
                ["nvim"] + selected,
                env={**os.environ, "VIM_KNOB": "4"},
                cwd=THINGS_DIR,
            )
            return True
        return False


def recent(args):
    fzf = Fzf()
    period = args.thing[0] if args.thing else "1week"
    fzf.defaultCommand = (
        f"fd --changed-within {period} md " + "--exec stat -f '%m:%N:1:%N' {} | sort -r"
    )
    return fzf.run()


def search(args):
    fzf = Fzf()
    thingsSearchArgs = (
        ""
        + ("--witharchive " if args.witharchive else "")
        + ("--justarchive " if args.justarchive else "")
    )

    if args.name:
        searchPrefix = f"things-search {thingsSearchArgs}-n {args.name}"
    else:
        searchPrefix = f"things-search {thingsSearchArgs}-n headings"
    if args.thing and len(args.thing) > 0:
        pattern = " ".join(args.thing)
        fzf.defaultCommand = f"{searchPrefix} '{pattern}' || true"
    else:
        fzf.defaultCommand = f"{searchPrefix} || true"

    return fzf.run()
