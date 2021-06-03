Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have the task ABC something
        Then the task context is ABC
        And the task garage is False
        And the task date is not set
        And the task mission is False
        And the task subject is something

    Scenario: Task in file
        Given I have the file my.md with task - [ ] ABC something
        Then the task file is my.md
        And the task context is ABC
        And the task subject is something

    Scenario: Garage task
        Given I have the task . something in garage
        Then the task garage is True
        Then the task mission is False
        And the task subject is something in garage

    Scenario: Mission task
        Given I have the task ~ something in mission
        Then the task garage is False
        Then the task mission is True
        And the task subject is something in mission

    Scenario: Markdown task
        Given I have the task - [ ] something
        Then the task subject is something

    Scenario: Task for now
        Given I have the task 0 something
        Then the task subject is something
        And the task date is ***

    Scenario: Task for the future
        Given I have the task 20500101 something
        Then the task subject is something
        And the task date is 01 JAN 2050

    Scenario: Task with to date
        Given I have the task 20500101 to 20500120 something
        Then the task subject is something
        And the task date is 01 JAN 2050
        And the task end is 20 JAN 2050
