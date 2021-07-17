#!/usr/bin/env python3

#
# Search things returning a stream of rows with 3 ":" separated parts ;
#
# 1) Sortable key, e.g. timestamp
# 2) Filename, i.e. where the match exists
# 3) Display string, i.e. what should be displayed in fzf
#

import argparse
from thingsdo import Rg, Environment


def run():
    parser = argparse.ArgumentParser(description="things")
    parser.add_argument("thing", nargs="*", help="thing")
    parser.add_argument("--witharchive", action="store_true")
    parser.add_argument("--justarchive", action="store_true")
    parser.add_argument("-n", "--name", help="search name", default="default")
    parser.add_argument("--nofilter", action="store_true")
    parser.add_argument("--dry", action="store_true")
    args = parser.parse_args()

    search(args)


def search(args):
    match = " ".join(args.thing)
    environment = Environment()

    if args.name == "default":
        search = Rg(environment, match)
        search.maxPerFile = 1
        search.postFilter = "s/^/0:/"
    elif args.name == "sort-modified":
        search = Rg(environment, match)
        search.withModifiedKey = True
        search.sort = True
        search.maxPerFile = 1
        search.postFilter = (
            "s/\\([^/]*\\).md:\\([0-9]*\\):\\(.*\\)/\\1.md:\\2:"
            + "\\3 \033[95m(\\1)\033[0m/"
        )
    elif args.name == "bookmarks":
        search = Rg(environment, match)
        search.withModifiedKey = True
        search.matchPrefix = "^\\[[0-9A-Za-z\\s\\.\\-]+\\]:.*"
    elif args.name == "headings":
        search = Rg(environment, match, args.justarchive, args.witharchive)
        search.matchPrefix = "^#+ .*"
        search.postFilter = (
            "s/\\([^/]*\\).md:\\([0-9]*\\):#\\(#*\\) \\(.*\\)/\\1.md:\\2:"
            + "\033[30m\\3\033[0m\\4 \033[95m(\\1)\033[0m/"
        )
        search.withModifiedKey = True
        search.sort = True
    else:
        raise Exception(f"Search {args.name} not recognised")

    if args.nofilter:
        search.filter = None
    # search.maxPerFile = 1
    search.run(args)
