Feature: Palette
    Colors in palette

    Scenario: Empty palette
        When I have the empty palette
        Then the color for x is empty

    Scenario: Todo palette
        When I have the todo palette
        Then the color for context is PURPLE
