import pytest
from pytest_bdd import scenarios, given, then, parsers
from .. import Task

scenarios("features/task.feature")


@pytest.fixture
def context():
    return dict()


@given(parsers.parse("default context is {defaultContext}"))
def default_context(context, defaultContext):
    context["defaultContext"] = defaultContext


@given("natural mode")
def natural_mode(context):
    context["natural"] = True


@given(parsers.parse("I have the task {task}"))
def tasks(context, task):
    context["givenTask"] = task
    defaultContext = context.get("defaultContext")
    natural = context.get("natural")
    today = context.get("today")
    file = context.get("file")
    kwargs = {}
    if today:
        kwargs["today"] = today
    if defaultContext:
        kwargs["defaultContext"] = defaultContext
    if natural:
        kwargs["natural"] = natural
    filePrefix = (file if file else "") + ":"
    context["task"] = Task(("" if natural else filePrefix) + task, **kwargs)


@given(parsers.parse("I am in the file {file}"))
def file(context, file):
    context["file"] = file


@then(parsers.parse("the task is as given"))
def thing_should_be(context):
    assert str(context["task"]) == context["givenTask"]
