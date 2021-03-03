Feature: Registration of positive likes
    In order to be able to express my liking for a content
    As a streaming platform user
    I want to be able to like one

    Background:
        Given the movie "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"

    Scenario: US5.1 - Successful registration of positive like
    Given I am registered as "john@test.com"
    And I saw content with id 0
    And I haven't liked the content with id 0
    When I positive like content with id 0
    Then I should receive "Calificación registrada" message

    Scenario: US5.2 - Double positive like
    Given I am registered as "john@test.com"
    And I saw content with id 0
    And I positive like content with id 0
    When I positive like content with id 0
    Then I should receive "Error: contenido ya calificado" message

    Scenario: US5.3 - Positive like to a not seen content
    Given I am registered as "john@test.com"
    And I haven't seen content with id 0
    When I positive like content with id 0
    Then I should receive "Error: contenido no visto" message

    Scenario: US5.4 - Successful registration of positive like of episode
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 1
    And I am registered as "john@test.com"
    And I saw content with id 0
    And I haven't liked the content with id 0
    When I positive like content with id 0
    Then I should receive "Calificación registrada" message

    Scenario: US5.5.1 - Successful registration of positive like of tv show
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 1
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 2
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 3
    And I am registered as "john@test.com"
    And I saw "The Office" season 1 episode 1
    And I saw "The Office" season 1 episode 2
    And I saw "The Office" season 1 episode 3
    And I positive liked "The Office" season 1 episode 1
    And I positive liked "The Office" season 1 episode 2
    And I positive liked "The Office" season 1 episode 3
    When I positive like "The Office"
    Then I should receive "Calificación registrada" message

    Scenario: US5.5.2 - Registration of positive like of tv show with 2 episodes liked
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 1
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 2
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 3
    And I am registered as "john@test.com"
    And I saw "The Office" season 1 episode 1
    And I saw "The Office" season 1 episode 2
    And I positive liked "The Office" season 1 episode 1
    And I positive liked "The Office" season 1 episode 2
    When I positive like "The Office"
    Then I should receive "No puede calificar este contenido aún" message