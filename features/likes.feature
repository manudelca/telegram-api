Feature: Registration of positive likes
    In order to be able to express my liking for a content
    As a streaming platform user
    I want to be able to like one

    Background:
        Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" is available with id 0

    Scenario: US5.1 - Successful registration of positive like
    Given I saw content with id 0
    And the user "john@test.com" "johncito" is registered
    And I haven't liked the content with id 0
    When I positive like content with id 0
    Then I should receive "Calificación registrada" message

    @wip
    Scenario: US5.2 - Double positive like
    Given I saw content with id 0
    And I positive liked content with id 0
    When I positive like content with id 0
    Then I should receive "Error: contenido ya calificado" message

    @wip
    Scenario: US5.3 - Positive like to a not seen content
    Given I haven't seen content with id 0
    When I positive like content with id 0
    Then I should receive "Error: contenido no visto" message