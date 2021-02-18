Feature: Add content to list
    In order to be able to save some content for a future view
    As a streaming platform user
    I want to be able to add a content to my list

    Background:

    @wip
    Scenario: US6.1 - Add content to list
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio", release date "2021-01-01"
    And I am registered as "john@test.com"
    When I add the movie "Titanic" to my list
    Then I should receive "Contenido agregado" message

    @wip
    Scenario: US6.2 - Add content to list a non-exitant content
    Given I am registered as "john@test.com"
    When I add the content with id 7987987 to my list
    Then I should receive "Error: contenido no encontrado" message

    @wip
    Scenario: US6.3 - Add content that is already present in the list
    Given the tv show "Sherlock", with audience "ATP", duration 90 min, genre "misterio", origin country "England", director "Paul McGuigan", actors "Benedict Cumberbatch" and "Martin Freeman", release date "2010-07-25"
    And I am registered as "john@test.com"
    And I add the tv show "Sherlock" to my list
    When I add the tv show "Sherlock" to my list
    Then I should receive "Error: el contenido ya se encuentra en la lista" message