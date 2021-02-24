Feature: Request releases
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to request new releases

    Background:
        Given I register the genre "drama"
        And I register the genre "action"
        And I register the genre "mystery"
        And today is "2021-02-21"

    @wip
    Scenario: US2.1 - Request releases successful
    Given the movie "Jurassic Park", with type "movie", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1980-06-10" is created
    And the movie "Matrix", with type "movie", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10" is created
    And the movie "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" is created
    And the tv show episode "Sherlock", with type "tv_show", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", release date "2010-07-25", season 1 and episode 1 is created
    When I request releases
    Then I should receive id, name, actors, director, genre and season (if tv show) from "Titanic", "Sherlock", "Matrix"

    @wip
    Scenario: US2.2 - It doesn't return future releases
    Given the movie "Matrix IV", with type "movie", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "2030-06-10" is created
    And the movie "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" is created
    And the tv show episode "Sherlock", with type "tv_show", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", release date "2010-07-25", season 1 and episode 1 is created
    And the movie "Matrix", with type "movie", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10" is created
    When I request releases
    Then I should receive id, name, actors, director, genre and season (if tv show) from "Titanic", "Sherlock", "Matrix"

    @wip
    Scenario: US2.3 - Request releases with 2 contents
    Given the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the tv show episode "Sherlock", with type "tv_show", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", release date "2010-07-25", season 1 and episode 1 is created
    When I request releases
    Then I should receive id, name, actors, director, genre and season (if tv show) from "Sherlock", "Matrix"

    @wip
    Scenario: US2.4 - Request releases with 1 future content
    Given the movie "Matrix IV", with type "movie", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "2030-06-10" is created
    When I request releases
    Then I should receive id, name, actors, director, genre and season (if tv show) from "Matrix IV", as future release

    Scenario: US2.5 - Request releases with 0 content
    Given No content is available
    When I request releases
    Then I should receive "No se encontro contenido!" message