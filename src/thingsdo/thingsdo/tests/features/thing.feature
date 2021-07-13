Feature: Things
    Normalise a thing

    Scenario: Thing
        When I have the thing my-collection/path/thing.md
        Then the thing base is thing

    Scenario: Date stream thing
        When I have the thing my-collection/stream/0425.md
        Then the thing base is 0425
        And the thing path is stream
        And the thing is not normal
        And the thing normalFilename is my-collection/stream/archive/2021/210425.md

    Scenario: No path thing
        When I have the thing my-collection/thing.md
        Then the thing base is thing
        And the thing is normal
        And the thing path is not set
