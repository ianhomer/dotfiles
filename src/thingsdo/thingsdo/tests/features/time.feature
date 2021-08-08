Feature: Human Time
    Convert a time into a human readable time

    Scenario: Today
        When I have the time 1415
        Then the time display is 14:15
