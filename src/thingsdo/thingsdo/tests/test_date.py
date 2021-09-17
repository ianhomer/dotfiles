import pytest
from pytest_bdd import scenarios, when, parsers
from .. import HumanDate

scenarios("features/date.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the date {numbers}"))
def I_have_date(context, numbers):
    kwargs = {}
    if "today" in context:
        kwargs["today"] = context["today"]

    context["date"] = HumanDate(numbers, **kwargs)
