Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have a task ABC something
        Then the task context is ABC
        And the task garage is False
        And the task date is not set
        And the task mission is False
        And the task subject is something

    Scenario: Task in file
        Given I have a file my.md with task ABC something
        Then the task file is my.md
        And the task subject is something

    Scenario: Garage task
        Given I have a task . something in garage
        Then the task garage is True
        Then the task mission is False
        And the task subject is something in garage

    Scenario: Mission task
        Given I have a task ~ something in mission
        Then the task garage is False
        Then the task mission is True
        And the task subject is something in mission
