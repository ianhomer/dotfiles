import pytest
from pytest_bdd import scenarios, when, parsers
from .. import HumanTime

scenarios("features/time.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the time {numbers}"))
def I_have_time(context, numbers):
    context["time"] = HumanTime(numbers)
