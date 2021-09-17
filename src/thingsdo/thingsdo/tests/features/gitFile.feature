Feature: Git File
    Get git file from file

    Scenario: File in git root
        Given I am in directory /tmp/foo
        And git root is bar
        When I have the file bar/file.txt
        Then the file path is file.txt
        And the file root is /tmp/foo/bar

