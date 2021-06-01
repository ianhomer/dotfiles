from pytest_bdd import scenarios, given, then, parsers

from dot.task import Task

scenarios("features")


@given(parsers.parse("I have a task {task}"), target_fixture="tasks")
def tasks(task):
    return dict(task=Task(":" + task))


@given(parsers.parse("I have a file {file} with task {task}"), target_fixture="tasks")
def file_with_task(file, task):
    return dict(task=Task(file + ":" + task))


@then(parsers.parse("the {thing} {field} is {value}"))
def thing_should_have_field_value(tasks, thing, field, value):
    assert getattr(tasks[thing], field) == value


@then(parsers.parse("the {thing} {field} is not set"))
def thing_should_not_have_field_set(tasks, thing, field):
    assert getattr(tasks[thing], field) is None
