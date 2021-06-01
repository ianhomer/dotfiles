Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have a task ABC something
        Then the task context is ABC
        And the task backlog is False
        And the task date is not set
        And the task roadmap is False
        And the task subject is something

    Scenario: Task in file
        Given I have a file my.md with task ABC something
        Then the task file is my.md
        And the task subject is something

    Scenario: Backlog task
        Given I have a task . something in backlog
        Then the task backlog is True
        Then the task roadmap is False
        And the task subject is something in backlog

    Scenario: Roadmap task
        Given I have a task ~ something in backlog
        Then the task backlog is False
        Then the task roadmap is True
        And the task subject is something in backlog
