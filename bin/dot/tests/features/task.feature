Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have task ABC something
        Then the context is ABC
        And the subject is something
        And the date is not set

    Scenario: Task in file
        Given I have file my.md with task ABC something
        Then the file is my.md

