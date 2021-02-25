Feature: Security with API_KEY
    In order to be able to have a safe interaction
    As a streaming platform user
    I want to be able to use an API_KEY

    @wip
    Scenario: US11.1 - Valid API_KEY
    Given the api token is "API_TOKEN"
    When I make a request with the api key "API_TOKEN"
    Then I should receive the request answer

    @wip
    Scenario: US11.2 - API_KEY not valid
    Given the api token is "API_TOKEN"
    When I make a request with the api key "FAKE_API_TOKEN"
    Then I should receive not authorized error
