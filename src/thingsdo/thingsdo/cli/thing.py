#!/usr/bin/env python3

import argparse
import os
import subprocess
import re
from datetime import datetime
from pathlib import Path
from thingsdo.factory import Factory
from thingsdo.environment import Environment
from .. import thingity


def run():
    parser = argparse.ArgumentParser(description="thing")
    parser.add_argument("thing", nargs="*", help="thing")
    parser.add_argument("-m", "--my", help="synk my things", action="store_true")
    parser.add_argument("--synk", help="synk things", action="store_true")

    # General settings
    parser.add_argument("--noconfig", help="ignore config files", action="store_true")

    args = parser.parse_args()

    environment = Environment.withConfig(not args.noconfig)

    if thingity.synk(args.synk, args.my):
        return

    edit(environment, args)


def edit(environment: Environment, args):
    now = datetime.now()
    words = []
    if args.thing and len(args.thing) > 0:

        # Thing is a named thing.
        for word in args.thing:
            words.append(word)

        kebab = re.sub("[^a-zA-Z0-9]", "-", "-".join(words).lower())
        filename = Factory(environment).getPath(kebab)
    else:
        # Thing is a today log.
        filename = Factory(environment).getTodayLog(now)

    if not os.path.isfile(filename):
        # Create a new thing.
        Path(filename).touch()
        with open(filename, "w") as file:
            if len(words) == 0:
                title = now.strftime("%a %d %b %Y").upper()
            else:
                title = " ".join(words)
            file.write(f"# {title}\n\n\n")

    # Edit a thing.
    subprocess.call(
        ["nvim", filename, "+:$"],
        cwd=environment.directory,
    )
