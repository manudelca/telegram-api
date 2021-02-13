Feature: Register content
    In order to be able to provide content to streaming platform users
    As a streaming platform
    I want to be able to register content

    Scenario: US8.1 - Register content successfully
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "El contenido fue registrado exitosamente!" message

    Scenario: US8.2 - Register content with an unregistered genre
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: genero drama_unregistered no registrado previamente" message

    Scenario: US8.3 - Register content without a name
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and other movie with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: falta el nombre de uno de tus contenidos" message

    Scenario: Register content without audience
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with no audience, duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: falto la clasificacion de audiencia de uno de tus contenidos" message

    Scenario: Register content without director
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", without director, actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: falto el director en uno de tus contenidos" message

    Scenario: Register content without actors
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", without actors, release date "2021-01-01"
    Then I should receive "Error: faltaron los actores de uno de tus contenidos" message

    Scenario: Register content without duration
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", without duration, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: falta la duracion de uno de tus contenidos" message

    Scenario: Register content without release date
    Given I register the genre "drama"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", without release date
    Then I should receive "Error: falta la fecha de estreno en uno de tus contenidos" message

    Scenario: Register tv show without seasons
    Given I register the genre "comedy"
    When I register the tv show "The Office", with audience "No ATP", genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", without seasons and episodes 200, release date "2021-01-01"
    Then I should receive "Error: falta la cantidad de temporadas en uno de tus contenidos"

    Scenario: Register tv show without episodes
    Given I register the genre "comedy"
    When I register the tv show "The Office", with audience "No ATP", genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and without episodes, release date "2021-01-01"
    Then I should receive "Error: falta la cantidad de episodios en uno de tus contenidos"

    Scenario: US8.4 - Register an already registered content
    Given I register the genre "drama"
    When I register the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    When I register the movies "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    Then I should receive "Error: el contenido ya fue registrado previamente" message
