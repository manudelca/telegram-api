Feature: Register user views
    In order to be able to provide a better recommendation service
    As a streaming platform
    I want to be able to register what users have seen

    Scenario: US9.1 - Movie seen by an user
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" and release date '2020-01-01' is available
    Given the user "john@test.com" is registered
    When  I marked the movie as seen for "john@test.com"
    Then I should get "Visto registrado exitosamente"

    Scenario: Non-existing movie
    Given there is no movie with id 123456700
    Given the user "john@test.com" is registered
    When I marked the movie as seen for "john@test.com"
    Then I should get "Error: el contenido con id 123456700 no se encuentra registrado"

    Scenario: Non-existing user
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" and release date '2020-01-01' is available
    When I marked the movie as seen for "mail_no_registrado@test.com"
    Then I should get "Error: el usuario con email mail_no_registrado@test.com no se encuentra registrado"

    Scenario: US9.2 - Episode seen by an user
    Given the episode  the tv show "The Office", with audience "No ATP", duration 20 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and episodes 200 and release date '2020-01-01' is available
    Given the user "john@test.com" is registered
    When I marked the episode 1 of tv show "The Office" for "john@test.com"
    Then I should get "Visto registrado exitosamente"

    Scenario: US13 - Shouldn't be able to mark as seen content not released
    Given today is "2021-02-03"
    Given the episode  the tv show "The Office", with audience "No ATP", duration 20 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and episodes 200 and release date '2021-02-05' is available
    Given the user "john@test.com" is registered
    When I marked the episode 1 of tv show "The Office" for "john@test.com"
    Then I should get "Error: no se puede registrar como visto contenido no estrenado"