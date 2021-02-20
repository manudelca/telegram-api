Feature: Registration
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to register

    
    Scenario: US1.1 - Successful registration
    Given My user id is 123456789
    When I register as "john@test.com"
    Then I should receive "Bienvenido! :)" message

    
    Scenario: US1.2 - Registration without email
    Given My user id is 123456789
    When I register without an email
    Then I should receive "Error: falta el campo email" message

    Scenario: US1.3 - Registration with repeated mail
    Given someone with id 123 registered as "john@test.com"
    When I register as "john@test.com"
    Then I should receive "Error: este email ya se encuentra registrado" message

    @wip
    Scenario: US1.4 - Registration with invalid mail
    When I register as "john@test"
    Then I should receive "Error: email es inválido, por favor ingrese un mail válido. Ej: /register mail@dominio.com" message