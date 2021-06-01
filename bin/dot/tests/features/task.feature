Feature: Task
    Parse a task

    Scenario: Simple task
        Given I have task ABC something
        Then the context is ABC
        And the subject is something

