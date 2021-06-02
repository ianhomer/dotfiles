import pytest
from pytest_bdd import scenarios, given, then, parsers

from dot.task import Task
from dot.date import Date

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


@given(parsers.parse("I have the date {numbers}"), target_fixture="context")
def date(numbers):
    return dict(date=Date(numbers))
