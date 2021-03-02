Feature: Security with API_KEY
    In order to be able to have a safe interaction
    As a streaming platform user
    I want to be able to use an API_KEY

    Scenario: US11.1 - Valid API_KEY
    Given the api key is "API_KEY"
    When I make a request with the api key "API_KEY"
    Then I should receive the request answer

    Scenario: US11.2 - API_KEY not valid
    Given the api key is "API_KEY"
    When I make a request with the api key "FAKE_API_KEY"
    Then I should receive "Not authorized Error" message
