Feature: Request releases
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to request new releases

    @wip
    Scenario: US2.1 - Request releases successful
    Given the movie "Jurassic Park", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1980-06-10"
    And the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25"
    When I request releases
    Then I should receive id, name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Titanic". "Sherlock"

    @wip
    Scenario: US2.2 - It doesn't return future releases
    Given the movie "Matrix IV", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "2030-06-10"
    And the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25" 
    And the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    When I request releases
    Then I should receive id, name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Titanic", "Sherlock"

    @wip
    Scenario: US2.3 - Request releases with 2 contents
    Given the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25" 
    When I request releases
    Then I should receive id, name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Sherlock"

    @wip
    Scenario: US2.4 - Request releases with 1 future content
    Given the movie "Matrix IV", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "2030-06-10"
    When I request releases
    Then I should receive id, name, 2 actors, el director, genre and season (if tv show) from "Matrix IV", as future release

    @wip
    Scenario: US2.5 - Request releases with 0 content
    Given No content is available
    When I request releases
    Then I should receive "No content available" message