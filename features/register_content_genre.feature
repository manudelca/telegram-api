Feature: Register Content genre
    In order to be able to register content
    As a streaming platform
    I want to be able to register a content genre

    Scenario: US7.1 - Register genre successfully
    When I register the genre "comedy"
    Then I should receive "Genero comedy fue registrado exitosamente!" message
    And the genre "comedy" should be created

    Scenario: US7.2 - Register invalid genre whitout a name
    When I register a genre without a name
    Then I should receive "Error: falta el campo genero" message

    @wip
    Scenario: US7.3 - Register an already registered genre
    Given I register the genre "comedy"
    When I register the genre "comedy"
    Then I should receive "Error: el genero comedy ya fue registrado" message