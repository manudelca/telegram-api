Feature: Request detail
    In order to be able to see details of a particular content
    As a streaming platform user
    I want to be able to ask them

    Scenario: US3.1.1 - Request movie details
    Given the movie "Titanic", with audience "ATP", duration 195 min, genre "drama", origin country "USA", director "James Cameron", actors "Kate Winslet" and "Leonardo Dicaprio" is available with id 0
    When I request details about the content with id 0
    Then I should recieve "Titanic, ATP, drama, USA, James Cameron, Kate Winslet and Leonardo Dicaprio"

    Scenario: US3.1.2 - Request none existant content details
    Given the content with id 90 doesn't exist
    When I request details about the content with id 90
    Then I should recieve a "Error: id not in the collection" message

    Scenario: US3.2 - Request tv show details
    Given the tv show "The Office", with audience "No ATP", genre "comedy", origin country "USA", director "Ricky Gervais", actors "Steve Carrell" and "Rainn Wilson", seasons 7 and episodes 200 is available with id 1
    When I request details about a content with id 1
    Then I should recieve "The Office, No ATP, comedy, USA, Ricky Gervais, Steve Carrell and Rainn Wilson"