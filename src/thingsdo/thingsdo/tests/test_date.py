import pytest
from pytest_bdd import scenarios, when, then, parsers
from .. import HumanDate

scenarios("features/date.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the date {numbers}"))
def I_have_date(context, numbers):
    context["date"] = HumanDate(numbers, 0, context["today"])


@then(parsers.parse("the date as numbers are {value}"))
def filter_should_have_pattern(context, value):
    assert context["date"].asNumbers() == value
