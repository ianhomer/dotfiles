import pytest
from pytest_bdd import scenarios, given, parsers
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
    context["task"] = Task(
        ":" + task, defaultContext=context.get("defaultContext")
    )


@given(parsers.parse("I have the file {file} with task {task}"))
def file_with_task(context, file, task):
    context["task"] = Task(file + ":" + task)
