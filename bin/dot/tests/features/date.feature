Feature: Human Date
    Convert a date into a human readable date

    Scenario: Today
        Given today
        When I have the date 0
        Then the date display is ***

    Scenario: Future
        Given today
        When I have the date 25000101
        Then the date display is 25000101

    Scenario: Next Month
        Given today is 20210601
        When I have the date 20210701
        Then the date display is 01 JUL

    Scenario: Tomorrow
        Given today is 20210601
        When I have the date 2
        Then the date display is WED
