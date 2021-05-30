from unittest import TestCase

from dot.task import Task


class TestTask(TestCase):
    def test_task(self):
        task = Task("my.md:ABC do this")
        self.assertEqual(task.context, "ABC")
        self.assertEqual(task.file, "my.md")
        self.assertEqual(task.subject, "do this")
        self.assertIsNone(task.date)
