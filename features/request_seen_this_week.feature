Feature: Request content seen this week
    In order to be able to operate with the platform content
    As a streaming platform user
    I want to be able to request content seen by me this week

    Scenario: US10.1 - Request content seen this week successful
    Given the movie "Jurassic Park", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1980-06-10"
    And the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25"
    And "john@test.com" saw the movie "Jurassic Park" in "2021-01-01"
    And "john@test.com" saw the movie "Matrix" in "2021-01-02"
    And "john@test.com" saw the movie "Titanic" in "2021-01-03"
    And "john@test.com" saw the tv show "Sherlock", season 1 episode 1 in "2021-01-04"
    And I haven't qualified any content
    And today is "2021-01-05"
    When I request content seen this week
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Titanic". "Sherlock"

    Scenario: US10.2 - Same content seen 2 times
    Given the movie "Jurassic Park", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1980-06-10"
    And the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25"
    And "john@test.com" saw the movie "Jurassic Park" in "2021-01-01"
    And "john@test.com" saw the movie "Sherlock" in "2021-01-9"
    And "john@test.com" saw the movie "Matrix" in "2021-01-10"
    And "john@test.com" saw the movie "Jurassic Park" in "2021-01-10"
    And "john@test.com" saw the movie "Titanic" in "2021-01-11"
    And I haven't qualified any content
    And today is "2021-01-12"
    When I request content seen this week
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Titanic". "Jurassic Park"

    Scenario: US10.3 - One calificated content
    Given the movie "Jurassic Park", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1980-06-10"
    And the movie "Matrix", with audience "ATP", duration 150 min, genre "action", origin country "USA", director "Lana Wachowski", actors "Keanu Reeves" and "Carrie-Anne Moss", release date "1999-06-10"
    And the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And the episode  the tv show "Sherlock", with audience "ATP", duration 90 min, genre "mystery", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", season 1 and episode 1, release date "2010-07-25"
    And "john@test.com" saw the movie "Jurassic Park" in "2021-01-01"
    And "john@test.com" saw the movie "Matrix" in "2021-01-02"
    And "john@test.com" saw the movie "Titanic" in "2021-01-03"
    And "john@test.com" saw the movie "Sherlock" in "2021-01-04"
    And I positive liked content "Sherlock"
    And today is "2021-01-05"
    When I request content seen this week
    Then I should receive name, 2 actors, el director, genre and season (if tv show) from "Matrix", "Titanic". "Jurassic Park"

    Scenario: US10.4 - No content seen
    Given today is "2021-01-05"
    And I am registered as "john@test.com"
    When I request content seen this week
    Then I should receive "No viste nada esta semana" message