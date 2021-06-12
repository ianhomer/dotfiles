import pytest
from pytest_bdd import scenarios, given, then, parsers
from .. import Task

scenarios("features/task.feature")


@pytest.fixture
def context():
    return dict()


@given(parsers.parse("default context is {defaultContext}"))
def defaultContext(context, defaultContext):
    context["defaultContext"] = defaultContext


@given(parsers.parse("I have the task {task}"))
def tasks(context, task):
    context["givenTask"] = task
    defaultContext = context.get("defaultContext")
    today = context.get("today")
    kwargs = {}
    if today:
        kwargs["today"] = today
    if defaultContext:
        kwargs["defaultContext"] = defaultContext
    context["task"] = Task(":" + task, **kwargs)


@given(parsers.parse("I have the file {file} with task {task}"))
def file_with_task(context, file, task):
    context["task"] = Task(file + ":" + task)


@then(parsers.parse("the task is as given"))
def thing_should_be(context):
    assert str(context["task"]) == context["givenTask"]
