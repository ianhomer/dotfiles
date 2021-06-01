Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have a task ABC something
        Then the task context is ABC
        And the task subject is something
        And the task date is not set

    Scenario: Task in file
        Given I have a file my.md with task ABC something
        Then the task file is my.md
        And the task subject is something

