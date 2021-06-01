from pytest_bdd import scenarios, given, then, parsers
from unittest import TestCase

from dot.task import Task


class TestTask(TestCase):
    def test_task(self):
        task = Task("my.md:ABC do this")
        self.assertEqual(task.context, "ABC")
        self.assertEqual(task.file, "my.md")
        self.assertEqual(task.subject, "do this")
        self.assertIsNone(task.date)


scenarios("features")


@given(parsers.parse("I have task {task}"), target_fixture="tasks")
def tasks(task):
    return dict(task=Task(":" + task))


@given(parsers.parse("I have file {file} with task {task}"), target_fixture="tasks")
def file_with_tasks(file, task):
    return dict(task=Task(file + ":" + task))


@then(parsers.parse("the context is {context}"))
def task_should_have_context(tasks, context):
    assert tasks["task"].context == context


@then(parsers.parse("the subject is {subject}"))
def task_should_have_subject(tasks, subject):
    assert tasks["task"].subject == subject


@then(parsers.parse("the file is {file}"))
def task_should_have_file(tasks, file):
    assert tasks["task"].file == file
