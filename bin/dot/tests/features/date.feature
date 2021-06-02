Feature: Human Date
    Convert a date into a human readable date

    Scenario: Today
        Given I have the date 0
        Then the date display is ***

    Scenario: Future
        Given I have the date 25000101
        Then the date display is 25000101

