from pytest_bdd import scenarios, given, when, then, parsers


@then(parsers.parse("the {thing} {field} is {value}"))
def thing_should_have_field_value(context, thing, field, value):
    actual = getattr(context[thing], field)
    if value == "False":
        expected = False
    elif value == "True":
        expected = True
    else:
        expected = value
    assert actual == expected


@then(parsers.parse("the {thing} {field} is not set"))
def thing_should_not_have_field_set(context, thing, field):
    assert getattr(context[thing], field) is None
