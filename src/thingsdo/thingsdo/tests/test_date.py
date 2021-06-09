import pytest
from pytest_bdd import scenarios, given, when, then, parsers
from .. import HumanDate
from datetime import date

scenarios("features/date.feature")


@pytest.fixture
def context():
    return dict()


@when(parsers.parse("I have the date {numbers}"))
def I_have_date(context, numbers):
    context["date"] = HumanDate(numbers, 0, context["today"])


@given(parsers.parse("today"), target_fixture="context")
def today():
    return dict(today=date.today())


@given(parsers.parse("today is {numbers}"), target_fixture="context")
def todayMock(numbers):
    return dict(today=date(int(numbers[0:4]), int(numbers[4:6]), int(numbers[7:8])))



