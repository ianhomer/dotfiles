Feature: Context Filter
    Parser context filter

    Scenario: Excludes
        When I have the filter -A,-B
        Then the filter has excludes A,B

    Scenario: Children
        When I have the filter :A>B,C
        Then the filter for A has children B,C
        And the filter for A has family A,B,C
        And the filter for A has pattern (A|B|C)
