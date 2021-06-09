import pytest
from pytest_bdd import scenarios, given, parsers
from .. import Task

scenarios("features/task.feature")


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
