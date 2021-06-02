import pytest
from pytest_bdd import scenarios, given, when, then, parsers

from ..task import Task
from ..date import Date

from datetime import date

scenarios("features")


@pytest.fixture
def context():
    return dict()


@given(parsers.parse("I have the task {task}"), target_fixture="context")
def tasks(task):
    return dict(task=Task(":" + task))


@given(
    parsers.parse("I have the file {file} with task {task}"), target_fixture="context"
)
def file_with_task(file, task):
    return dict(task=Task(file + ":" + task))


@then(parsers.parse("the {thing} {field} is {value}"))
def thing_should_have_field_value(context, thing, field, value):
    actual = getattr(context[thing], field)
    if value == "False":
        expected = False
    elif value == "True":
        expected = True
    else:
        expected = value
    assert actual == expected


@then(parsers.parse("the {thing} {field} is not set"))
def thing_should_not_have_field_set(context, thing, field):
    assert getattr(context[thing], field) is None


@when(parsers.parse("I have the date {numbers}"))
def I_have_date(context, numbers):
    context["date"] = Date(numbers, 0, context["today"])


@given(parsers.parse("today"), target_fixture="context")
def today():
    return dict(today=date.today())


@given(parsers.parse("today is {numbers}"), target_fixture="context")
def todayMock(numbers):
    return dict(today=date(int(numbers[0:4]), int(numbers[4:6]), int(numbers[7:8])))
