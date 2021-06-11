from pytest_bdd import given, then, parsers

from datetime import date


@then(parsers.parse("the {thing} {field} is {expected}"))
def thing_should_have_field_value(context, thing, field, expected):
    actual = str(getattr(context[thing], field))
    assert actual == expected


@then(parsers.parse("the {thing} {field} is not set"))
def thing_should_not_have_field_set(context, thing, field):
    assert getattr(context[thing], field) is None


@given(parsers.parse("today"), target_fixture="context")
def today():
    return dict(today=date.today())


@given(parsers.parse("today is {numbers}"), target_fixture="context")
def todayMock(numbers):
    return dict(today=date(int(numbers[0:4]), int(numbers[4:6]), int(numbers[6:8])))
