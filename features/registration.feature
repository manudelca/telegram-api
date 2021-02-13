Feature: Registration
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to register

    @wip
    Scenario: US1.1 - Successful registration
    When I register as "john@test.com"
    Then I should recieve a welcome message

    @wip
    Scenario: US1.2 - Registration without email
    When I register without an email
    Then I should recieve a "Error: falta el campo email" message

    @wip
    Scenario: US1.3 - Registration with repeated mail
    Given someone has registered as "john@test.com" 
    When I register as "john@test.com"
    Then I should recieve a "Error: mail repetido" message

    @wip
    Scenario: US1.4 - Registration with invalid mail
    When I register as "john@test"
    Then I should recieve a "Error: mail invalido" message