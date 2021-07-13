import pytest
from pytest_bdd import scenarios, given, when, parsers
from .. import Thing

scenarios("features/thing.feature")


@pytest.fixture
def context():
    return dict()


@given(parsers.parse("root is {root}"))
def root(context, root):
    context["root"] = root


@when(parsers.parse("I have the thing {thing}"))
def I_have_thing(context, thing):
    root = context.get("thing")
    kwargs = {}
    if root:
        kwargs["root"] = root
    context["thing"] = Thing(thing, kwargs)
