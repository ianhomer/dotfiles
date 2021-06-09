import pytest
from pytest_bdd import scenarios, when, then, parsers
from .. import ContextFilter

scenarios("features/contextFilter.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the filter {filter}"))
def I_have_the_filter(context, filter):
    context["filter"] = ContextFilter(filter)


@then(parsers.parse("the filter has excludes {value}"))
def filter_should_have_field(context, value):
    assert context["filter"].excludes() == value.split(",")


@then(parsers.parse("the filter for {child} has children {value}"))
def filter_should_have_children(context, child, value):
    assert context["filter"].children(child) == value.split(",")
