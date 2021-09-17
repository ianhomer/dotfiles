import pytest
from pytest_bdd import scenarios, given, when, parsers
from .. import GitFile

scenarios("features/gitFile.feature")


@pytest.fixture
def context():
    return dict()


@given(parsers.parse("I am in directory {directory}"))
def I_am_in(context, directory):
    context["directory"] = directory


@given(parsers.parse("git root is {gitRoot}"))
def git_root_is(context, gitRoot):
    context["gitRoot"] = gitRoot


@when(parsers.parse("I have the file {path}"))
def I_have_the_file(context, path):
    context["file"] = GitFile(
        context["directory"],
        path,
        cmd=["echo", context["directory"] + "/" + context["gitRoot"]],
    )
