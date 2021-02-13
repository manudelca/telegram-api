Feature: Register user views
    In order to be able to provide a better recommendation service
    As a streaming platform
    I want to be able to register what users have seen

    @wip
    Scenario: US9.1 - Movie seen by an user
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" is available with id 0
    Given the user "john@test.com" is registered
    When  I marked the movie with id 0 as seen for "john@test.com"
    Then I should get "Visto registrado exitosamente"

    @wip
    Scenario: Non-existing movie
    Given there is no movie with id 0
    Given the user "john@test.com" is registered
    When I marked the movie with id 0 as seen
    Then I should get "Error: la pelicula con id 0 no se encuentra registrada"

    @wip
    Scenario: Non-existing user
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" is available with id 0
    Given the user "john@test.com" is registered
    When I marked the movie with id 0 as seen for "john@test.com"
    Then I should get "Error: el usario con mail id john@test.com no se encuentra registrada"

    @wip
    Scenario: US9.2 - Episode seen by an user
    Given the episode  the tv show "The Office", with audience "No ATP", genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and episodes 200 is available with id 1
    Given the user "john@test.com" is registered
    When I marked the episode 1 of tv show with id 1 for "john@test.com"
    Then I should get "Visto registrado exitosamente"