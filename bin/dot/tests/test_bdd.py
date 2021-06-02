from pytest_bdd import scenarios, given, when, then, parsers

from dot.task import Task
from dot.humanDate import HumanDate

scenarios("features")


@given(parsers.parse("I have a task {task}"), target_fixture="tasks")
def tasks(task):
    return dict(task=Task(":" + task))


@given(parsers.parse("I have a file {file} with task {task}"), target_fixture="tasks")
def file_with_task(file, task):
    return dict(task=Task(file + ":" + task))


@then(parsers.parse("the {thing} {field} is {value}"))
def thing_should_have_field_value(tasks, thing, field, value):
    actual = getattr(tasks[thing], field)
    if value == "False":
        expected = False
    elif value == "True":
        expected = True
    else:
        expected = value
    assert actual == expected


@then(parsers.parse("the {thing} {field} is not set"))
def thing_should_not_have_field_set(tasks, thing, field):
    assert getattr(tasks[thing], field) is None


@given(parsers.parse("I have a date {numbers}"), target_fixture="tasks")
def date(numbers):
    return dict(date=HumanDate(numbers))
