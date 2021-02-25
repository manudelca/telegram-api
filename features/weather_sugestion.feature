Feature: Weather sugestion
    In order to be able to have content recommendations based on my mood
    As a streaming platform user
    I want to be able to request sugestions based on the weather

    @wip
    Scenario: US4.1 - Weather sugestion for Clear
    Given the weather is "Clear"
    And the movie "21 Jump street 1", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 2", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 3", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "21 Jump street 1", "21 Jump street 2". "21 Jump street 3"

    @wip
    Scenario: US4.2 - Weather sugestion for Clouds
    Given the weather is "Clouds"
    And the movie "Matrix 1", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Matrix 2", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Matrix 3", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Matrix 1", "Matrix 2". "Matrix  3"

    @wip
    Scenario: US4.3 - Weather sugestion with no action content
    Given the weather is "Clouds"
    And the movie "21 Jump street 1", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1997-06-10"
    And the movie "21 Jump street 2", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1998-06-10"
    And the movie "21 Jump street 3", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "21 Jump street 3", "21 Jump street 2". "21 Jump street 1"

    @wip
    Scenario: US4.4 - Weather sugestion default
    Given the weather is "Drizzle"
    And the movie "21 Jump street 1", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1997-06-10"
    And the movie "21 Jump street 2", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1998-06-10"
    And the movie "21 Jump street 3", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "21 Jump street 3", "21 Jump street 2". "21 Jump street 1"
