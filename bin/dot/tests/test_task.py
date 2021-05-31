from pytest_bdd import scenario, given, when, then, parsers
from unittest import TestCase

from dot.task import Task


class TestTask(TestCase):
    def test_task(self):
        task = Task("my.md:ABC do this")
        self.assertEqual(task.context, "ABC")
        self.assertEqual(task.file, "my.md")
        self.assertEqual(task.subject, "do this")
        self.assertIsNone(task.date)


@scenario("task.feature", "Simple task")
def test_task():
    pass


@given(parsers.parse("I have task {task}"), target_fixture="tasks")
def tasks(task):
    return dict(task=Task(":" + task))


@then(parsers.parse("context for task is {context}"))
def task_should_have_context(tasks, context):
    assert tasks["task"].context == context
