Feature: Create a New User

  Scenario: Successfully create a new user
    Given I provide valid user details "Hanif" and "Afianto"
    When I send a request to create a user
    Then the response status should be 201
    And the user should be created with the correct details

  Scenario: Fail to create a user with missing name
    Given I provide user details "" and "Afianto"
    When I send a request to create a user
    Then the response status should be 400
    And the user should not be created

  Scenario: Fail to create a user with missing job
    Given I provide user details "Hanif" and ""
    When I send a request to create a user
    Then the response status should be 400
    And the user should not be created

  Scenario: Fail to create a user with non-string values
    Given I provide user details "12345" and "67890"
    When I send a request to create a user
    Then the response status should be 400
    And the user should not be created

  Scenario: Fail to create a user with an empty JSON payload
    Given I provide an empty JSON payload
    When I send a request to create a user
    Then the response status should be 400
    And the user should not be created

  Scenario: Fail to create a user with an invalid JSON format
    Given I provide an invalid JSON payload
    When I send a request to create a user
    Then the response status should be 400
    And the user should not be created
