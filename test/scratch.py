#!/usr/bin/env python3

#
# Python scratch pad
#

from uuid import uuid4
from scratch_module import FOO

def foo(bar):
    print(f"foo executed with {bar}")
    return "value"


print(FOO)
print(uuid4())
bar = "hello"
foo(bar)
