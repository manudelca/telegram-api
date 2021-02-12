Feature: Register content
    In order to be able to provide content to streaming platform users
    As a streaming platform
    I want to be able to register content

    Scenario: US8.1 - Register content successfully
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr"
    Then I should receive "El contenido fue registrado exitosamente!" message

    Scenario: US8.2 - Register content with an unregistered genre
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr"
    Then I should receive "Error: genero drama_unregistered no registrado previamente" message

    Scenario: US8.3 - Register content without a name
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" and other movie with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr"
    Then I should receive "Error: falta el nombre de uno de tus contenidos" message

    Scenario: US8.4 - Register an already registered content
    Given I register the genre "drama"
    When I register the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio"
    Then I should receive "Error: el contenido ya fue registrado previamente" message
