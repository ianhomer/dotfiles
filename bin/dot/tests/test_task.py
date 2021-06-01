from pytest_bdd import scenarios, given, then, parsers

from dot.task import Task

scenarios("features")


@given(parsers.parse("I have task {task}"), target_fixture="tasks")
def tasks(task):
    return dict(task=Task(":" + task))


@given(parsers.parse("I have file {file} with task {task}"), target_fixture="tasks")
def file_with_tasks(file, task):
    return dict(task=Task(file + ":" + task))


@then(parsers.parse("the {field} is {value}"))
def task_should_have_field_value(tasks, field, value):
    assert getattr(tasks["task"], field) == value


@then(parsers.parse("the {field} is not set"))
def task_should_not_have_field_set(tasks, field):
    assert getattr(tasks["task"], field) is None
