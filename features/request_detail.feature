Feature: Request detail
    In order to be able to see details of a particular content
    As a streaming platform user
    I want to be able to ask them

    Scenario: US3.1.1 - Request movie details
    Given the movie "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    When I get the last movie created
    Then I should receive "El contenido fue encontrado!" message

    Scenario: US3.1.2 - Request none existant content details
    When I request details about the a none existant content
    Then I should receive "Error: id no se encuentra en la coleccion" message

    Scenario: US3.2 - Request tv show details
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 1
    When I get the last tv_show created
    Then I should receive "El contenido fue encontrado!" message