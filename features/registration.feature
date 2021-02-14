Feature: Registration
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to register

    
    Scenario: US1.1 - Successful registration
    When I register as "john@test.com"
    Then I should receive "Bienvenido! :)" message

    @wip
    Scenario: US1.2 - Registration without email
    When I register without an email
    Then I should receive "Error: falta el campo email" message

    @wip
    Scenario: US1.3 - Registration with repeated mail
    Given someone has registered as "john@test.com" 
    When I register as "john@test.com"
    Then I should receive "Error: mail repetido" message

    @wip
    Scenario: US1.4 - Registration with invalid mail
    When I register as "john@test"
    Then I should receive "Error: mail invalido" message