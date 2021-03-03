Feature: Add content to list
    In order to be able to save some content for a future view
    As a streaming platform user
    I want to be able to add a content to my list

    Scenario: US6.1 - Add content to list
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" is available
    And I register myself with the email "john@test.com"
    When I add the movie to my list
    Then I should receive "Contenido agregado a la lista exitosamente" message

    Scenario: US6.2 - Add content to list a non-exitant content
    Given I register myself with the email "john@test.com"
    When I add a non-existant movie to my list
    Then I should receive "Contenido inexistente, no es posible añadirlo a la lista" message

    Scenario: US6.3 - Add content that is already present in the list
    Given the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", release date "2004-01-01", season 1 and episode 1
    And I register myself with the email "john@test.com"
    When I add the tv show "The Office" to my list
    And I add the tv show "The Office" to my list
    Then I should receive "Ya has añadido este contenido a tu lista" message

    Scenario: US6.4 - Add content to list of a non-existant client
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    When I add the movie to a non-existant clien list
    Then I should receive "Error: el usuario no se encuentra registrado" message