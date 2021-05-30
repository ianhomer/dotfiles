from pytest_bdd import scenario, given, when, then
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


@given("tasks", target_fixture="tasks")
def tasks():
    return dict()


@when("I have task")
def have_task(tasks):
    tasks["task"] = Task(":ABC something")


@then("context OK")
def should_have_context(tasks):
    assert tasks["task"].context == "ABC"
