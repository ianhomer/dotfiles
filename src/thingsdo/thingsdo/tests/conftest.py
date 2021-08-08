from pytest_bdd import given, then, parsers

from datetime import date


@then(parsers.parse("the {thing:l} {field:l} is {expected}"))
def thing_should_have_field_value(context, thing, field, expected):
    assert str(getattr(context[thing], field)) == expected


@then(parsers.parse("the {thing:l} is not {expected}"))
def thing_should_not_be(context, thing, expected):
    if hasattr(context[thing], expected):
        assert not getattr(context[thing], expected)
    else:
        assert str(context[thing]) != expected


@then(parsers.parse("the {thing:l} is {expected}"))
def thing_should_be(context, thing, expected):
    if hasattr(context[thing], expected):
        assert getattr(context[thing], expected)
    else:
        assert str(context[thing]) == expected


@then(parsers.parse("the {thing:l} {field:l} is not set"))
def thing_should_not_have_field_set(context, thing, field):
    assert getattr(context[thing], field) is None


@given(parsers.parse("today is {numbers}"))
def todayMock(context, numbers):
    context["today"] = date(int(numbers[0:4]), int(numbers[4:6]), int(numbers[6:8]))
