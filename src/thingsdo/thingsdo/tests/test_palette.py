import pytest
from pytest_bdd import scenarios, when, then, parsers
from .. import Palette

scenarios("features/palette.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the empty palette"))
def I_have_time(context):
    context["palette"] = Palette()


@then(parsers.parse("the color for {name} is empty"))
def color_should_be_empty(context, name):
    assert context["palette"].color(name) == ""
