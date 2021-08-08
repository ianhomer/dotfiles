#!/usr/bin/env python3

#
# Take a stream from things-search where the first two columns are the file and
# then line number for the match and prepend the line with a string that allows
# sorting ontime modified of file and line number. This prepare content for fzf
# efficiently.
#
import sys
import os.path


def run():
    indexes = {}
    for line in sys.stdin:
        first = line.find(":")
        second = line.find(":", first + 1)
        filename = line[:first]
        index2 = str(1000 + int(line[first + 1 : second]))
        # index is based on modified time appended with hash of the filename.
        # Hash of filename mitigates collisions when files have same modified
        # time, resulting in interlacing of results when sorted
        if filename not in indexes:
            indexes[filename] = str(
                10000000000000 - int(os.path.getmtime(filename))
            ) + str(hash(filename))
        index1 = indexes[filename]
        out = index1 + "-" + index2 + ":" + line
        sys.stdout.write(out)
