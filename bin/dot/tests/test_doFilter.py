from unittest import TestCase

from dot.doFilter import DoFilter


class TestDoFilter(TestCase):
    def test_doFilter(self):
        doFilter = DoFilter("-A,-B")
        self.assertEqual(["A", "B"], doFilter.excludes())
