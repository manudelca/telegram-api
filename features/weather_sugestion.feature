Feature: Weather sugestion
    In order to be able to have content recommendations based on my mood
    As a streaming platform user
    I want to be able to request sugestions based on the weather

    @wip
    Scenario: US4.1 - Weather sugestion for Thunderstorm
    Given the weather is "Thunderstorm"
    And the movie "Amanecer de los muertos 1", with audience "ATP", duration 150 min, genre "terror", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10" 
    And the movie "Amanecer de los muertos 2", with audience "ATP", duration 150 min, genre "terror", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Amanecer de los muertos 3", with audience "ATP", duration 150 min, genre "terror", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Amanecer de los muertos 1", "Amanecer de los muertos 2". "Amanecer de los muertos 3"

    @wip
    Scenario: US4.2 - Weather sugestion for Drizzle
    Given the weather is "Drizzle"
    And the movie "Los vengadores 1", with audience "ATP", duration 150 min, genre "pochoclero", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Los vengadores 2", with audience "ATP", duration 150 min, genre "pochoclero", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Los vengadores 3", with audience "ATP", duration 150 min, genre "pochoclero", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Los vengadores 1", "Los vengadores 2". "Los vengadores 3"

    @wip
    Scenario: US4.3 - Weather sugestion for Rain
    Given the weather is "Rain"
    And the movie "Diario de una pasion 1", with audience "ATP", duration 150 min, genre "romantico", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Diario de una pasion 2", with audience "ATP", duration 150 min, genre "romantico", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Diario de una pasion 3", with audience "ATP", duration 150 min, genre "romantico", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Diario de una pasion 1", "Diario de una pasion 2". "Diario de una pasion 3"

    @wip
    Scenario: US4.4 - Weather sugestion for Snow
    Given the weather is "Snow"
    And the movie "Life of pi 1", with audience "ATP", duration 150 min, genre "drama", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Life of pi 2", with audience "ATP", duration 150 min, genre "drama", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Life of pi 3", with audience "ATP", duration 150 min, genre "drama", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Life of pi 1", "Life of pi 2". "Life of pi 3"

    @wip
    Scenario: US4.5 - Weather sugestion for Atmosphere
    Given the weather is "Atmosphere"
    And the movie "Fragmentado 1", with audience "ATP", duration 150 min, genre "suspenso", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Fragmentado 2", with audience "ATP", duration 150 min, genre "suspenso", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Fragmentado 3", with audience "ATP", duration 150 min, genre "suspenso", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Fragmentado 1", "Fragmentado 2". "Fragmentado 3"

    @wip
    Scenario: US4.6 - Weather sugestion for Clear
    Given the weather is "Clear"
    And the movie "21 Jump street 1", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 2", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 3", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "21 Jump street 1", "21 Jump street 2". "21 Jump street 3"

    @wip
    Scenario: US4.7 - Weather sugestion for Clouds
    Given the weather is "Clouds"
    And the movie "Matrix 1", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Matrix 2", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Matrix 3", with audience "ATP", duration 150 min, genre "accion", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Matrix 1", "Matrix 2". "Matrix  3"

    @wip
    Scenario: US4.8 - Weather sugestion with no action content
    Given the weather is "Clouds"
    And the movie "21 Jump street 1", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 2", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "21 Jump street 3", with audience "ATP", duration 150 min, genre "comedia", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And I request a content sugestion
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "21 Jump street 1", "21 Jump street 2". "21 Jump street 3"
