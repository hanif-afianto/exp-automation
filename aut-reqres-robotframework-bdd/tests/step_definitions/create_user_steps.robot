*** Settings ***
Resource    ../../resources/keywords/create_user_keywords.resource
Resource    ../../resources/variables/user_variables.resource
Library    Collections
Library    allure_robotframework

*** Test Cases ***
Create a new user successfully
    [Tags]    
    ...    API    
    ...    CreateUser    
    ...    Positive
    ...    AllureSuite:Create User API
    Given I provide user details    ${USER_NAME}    ${USER_JOB}
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

Fail to create a user with missing name
    [Tags]    
    ...    API    
    ...    CreateUser    
    ...    Negative
    ...    AllureSuite:Create User API
    Given I provide user details    ${EMPTY}    Afianto
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

Fail to create a user with missing job
    [Tags]    
    ...    API    
    ...    CreateUser    
    ...    Negative
    ...    AllureSuite:Create User API
    Given I provide user details    Hanif    ${EMPTY}
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

Fail to create a user with non-string values
    [Tags]    API    CreateUser    Negative
    Set Tags    AllureSuite:Create User API
    Log    Fail to create a user with non-string values
    Given I provide user details    12345    67890
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

Fail to create a user with an empty JSON payload
    [Tags]    API    CreateUser    Negative
    Set Tags    AllureSuite:Create User API
    Log    Fail to create a user with an empty JSON payload
    Given I provide an empty JSON payload
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

Fail to create a user with invalid JSON format
    [Tags]    API    CreateUser    Negative
    Set Tags    AllureSuite:Create User API
    Log    Fail to create a user with invalid JSON format
    Given I provide an invalid JSON payload
    When I send a request to create a user
    Then the response status should be    201
    And the user should be created with the correct details

*** Keywords ***
Given I provide user details
    [Arguments]    ${name}    ${job}
    Set Test Variable    ${USER_NAME}    ${name}
    Set Test Variable    ${USER_JOB}    ${job}

Given I provide an empty JSON payload
    Set Suite Variable    ${INVALID_PAYLOAD}    {}

Given I provide an invalid JSON payload
    Set Suite Variable    ${INVALID_PAYLOAD}    "{name: Hanif job:}"

When I send a request to create a user
    ${response}=    Create New User    ${USER_NAME}    ${USER_JOB}
    ${status_code}=    Set Variable    ${response.status_code}
    ${json_response}=    Run Keyword If    ${status_code} == 201    Set Variable    ${response.json()}    ELSE    Create Dictionary
    Set Suite Variable    ${CREATED_USER_RESPONSE}    ${json_response}
    Set Suite Variable    ${STATUS_CODE}    ${status_code}

Then the response status should be
    [Arguments]    ${expected_status}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${expected_status}
    Log    Expected status: ${expected_status}, Actual status: ${STATUS_CODE}

And the user should be created with the correct details
    Run Keyword If    ${STATUS_CODE} == 201    Validate Created User

Validate Created User
    Dictionary Should Contain Key    ${CREATED_USER_RESPONSE}    name
    Dictionary Should Contain Key    ${CREATED_USER_RESPONSE}    job
    Dictionary Should Contain Key    ${CREATED_USER_RESPONSE}    id
    Dictionary Should Contain Key    ${CREATED_USER_RESPONSE}    createdAt
