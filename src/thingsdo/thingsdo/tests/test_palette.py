import pytest
from pytest_bdd import scenarios, when, then, parsers
from .. import Palette

scenarios("features/palette.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the empty palette"))
def I_have_empty_palette(context):
    context["palette"] = Palette()


@when(parsers.parse("I have the {theme} palette"))
def I_have_named_palette(context, theme):
    context["palette"] = Palette(theme=theme)


@then(parsers.parse("the color for {name} is PURPLE"))
def color_should_be_purple(context, name):
    assert context["palette"].color(name) == "\033[95m"


@then(parsers.parse("the color for {name} is empty"))
def color_should_be_empty(context, name):
    assert context["palette"].color(name) == ""
