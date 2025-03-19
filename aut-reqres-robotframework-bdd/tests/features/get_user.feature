Feature: Retrieve a User

  Scenario: Successfully retrieve a user with a valid ID
    Given I have a valid user ID
    When I request the user details
    Then the response status should be "200"
    And the user details should match expectations

  Scenario: Fail to retrieve a user with an invalid ID
    Given I provide an invalid user ID "999"
    When I request the user details
    Then the response status should be "404"
    And the response should indicate user not found

  Scenario: Fail to retrieve a user with a non-numeric ID
    Given I provide an invalid user ID "invalid_id"
    When I request the user details
    Then the response status should be "404"
    And the response should indicate user not found