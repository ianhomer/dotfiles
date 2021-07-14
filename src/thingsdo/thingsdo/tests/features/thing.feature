Feature: Things
    Normalise a thing

    Scenario: Thing
        When I have the thing my-collection/path/thing.md
        Then the thing base is thing

    Scenario: Date stream this year thing
        Given today is 20210609
        When I have the thing my-collection/stream/0425.md
        Then the thing base is 0425
        And the thing path is stream
        And the thing is not normal
        And the thing normalFilename is my-collection/stream/archive/2021/20210425.md

    Scenario: Recent date stream thing
        Given today is 20210609
        When I have the thing my-collection/stream/0607.md
        Then the thing base is 0607
        And the thing path is stream
        And the thing normalFilename is my-collection/stream/0607.md
        And the thing is normal

    Scenario: Date stream with year from archive path
        Given today is 20210709
        When I have the thing my-collection/stream/archive/2019/0425.md
        Then the thing base is 0425
        And the thing is not normal
        And the thing normalFilename is my-collection/stream/archive/2019/20190425.md

    Scenario: Date stream last year thing
        Given today is 20210301
        When I have the thing my-collection/stream/0425.md
        Then the thing base is 0425
        And the thing path is stream
        And the thing is not normal
        And the thing normalFilename is my-collection/stream/archive/2020/20200425.md

    Scenario: No path thing
        When I have the thing my-collection/thing.md
        Then the thing base is thing
        And the thing is normal
        And the thing path is not set
