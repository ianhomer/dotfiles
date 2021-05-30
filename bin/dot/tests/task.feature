Feature: Task
    Parse a task

    Scenario: Simple task
        Given tasks
        When I have task
        Then context OK

