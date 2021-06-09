from unittest import TestCase

from .. import ContextFilter


class TestDoFilter(TestCase):
    def test_excludes(self):
        contextFilter = ContextFilter("-A,-B")
        self.assertEqual(["A", "B"], contextFilter.excludes())

    def test_children(self):
        contextFilter = ContextFilter(":A>B,C")
        self.assertEqual(["B", "C"], contextFilter.children("A"))
