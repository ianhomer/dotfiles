Feature: Human Date
    Convert a date into a human readable date

    Scenario: Today
        When I have the date 0
        Then the date display is ***
        And the date include is True

    Scenario: Future
        When I have the date 20500101
        Then the date display is 01 JAN 2050

    Scenario: Pass through of invalid date
        Given today is 20210610
        When I have the date 12345
        Then the date display is THU

    Scenario: Next Month
        Given today is 20210601
        When I have the date 20210701
        Then the date display is 01 JUL
        And the date include is True

    Scenario: Tomorrow
        Given today is 20210601
        When I have the date 2
        Then the date display is WED
        And the date include is True

    Scenario: Day of week
        Given today is 20210610
        When I have the date FRI
        Then the date code is 20210611
