Feature: Register content
    In order to be able to provide content to streaming platform users
    As a streaming platform
    I want to be able to register content

    Scenario: US8.1 - Register content successfully
    Given I register the genre "drama"
    When I register the movie "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and the tv show episode "Titanic: La Serie", with type "tv_show", with audience "ATP", duration 30 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01", season 1 and episode 1
    Then I should receive "El contenido fue registrado exitosamente!" message

    Scenario: US8.2 - Register content with an unregistered genre
    Given I register the genre "drama"
    When I register the movies "Titanic", with type "movie", with audience "ATP", duration 195 min, genre "drama_unregistered", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01" and "Titanic 2", with type "movie", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Debes agregar el género antes de crear este contenido" message

    Scenario: US8.3 - Register content without a name
    Given I register the genre "drama"
    When I register a movie without name, with type "movie", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", release date "2021-01-01"
    Then I should receive "Error: falta el nombre de uno de tus contenidos" message

    Scenario: Register content without release date
    Given I register the genre "drama"
    When I register the movies "Titanic", with type "movie", with audience "ATP", duration 205 min, genre "drama", origin country "USA Jr", director "James Cameron Jr", actors "Kate Winslet Jr" and "Leonardo Dicaprio Jr", without release date
    Then I should receive "Error: falta la fecha de estreno en uno de tus contenidos" message

    Scenario: Register tv show without seasons
    Given I register the genre "comedy"
    When I register the episode "The Office", with type "tv_show", with audience "No ATP", duration 30 min,  genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", without season and episode 3, release date "2021-01-01"
    Then I should receive "Error: falta el numero de temporada en uno de tus contenidos" message

    Scenario: Register tv show without episodes
    Given I register the genre "comedy"
    When I register the tv show "The Office", with type "tv_show", with audience "No ATP", duration 30 min, genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and without episodes, release date "2021-01-01"
    Then I should receive "Error: falta el numero de episodio en uno de tus contenidos" message

    Scenario: Register content without genre
    Given I register the genre "comedy"
    When I register the movies "Titanic", with type "movie", with audience "ATP", duration 195 min, without genre, origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    Then I should receive "Error: falta el genero en uno de tus contenidos" message

    Scenario: US8.4 - Register an already registered content
    Given I register the genre "drama"
    Given I register the genre "comedy"
    When I register the movie "Titanic", with audience "No ATP", duration 185 min, genre "comedy", origin country "Canada", director "John Cameron", actors "Mary Winslet" and "Harry Dicaprio", release date "2021-01-01"
    When I register the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    Then I should receive "Error: el contenido ya fue registrado previamente" message
