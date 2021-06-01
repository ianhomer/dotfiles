Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have task ABC something
        Then the context is ABC
        And the subject is something
        And the date is not set
        And the backlog is False
        And the roadmap is False

    Scenario: Task in file
        Given I have file my.md with task ABC something
        Then the file is my.md
        And the subject is something

    Scenario: Backlog task
        Given I have task something in backlog
        Then the roadmap is True

