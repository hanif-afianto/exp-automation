*** Settings ***
Resource    ../../resources/keywords/get_user_keywords.resource
Resource    ../../resources/variables/user_variables.resource
Library    Collections
Library    allure_robotframework

*** Test Cases ***
Retrieve a user with a valid ID
    [Tags]    API    GetUser    Positive
    Set Tags    AllureSuite:Get User API
    Log    Retrieve a user with a valid ID
    Given I have a user ID    ${USER_ID}
    When I request the user details
    Then the response status should be    200
    And the user details should be correct

Fail to retrieve a user with an invalid ID
    [Tags]    API    GetUser    Negative
    Set Tags    AllureSuite:Get User API
    Log    Fail to retrieve a user with an invalid ID
    Given I have a user ID    999
    When I request the user details
    Then the response status should be    404
    And the response should indicate user not found

Fail to retrieve a user with a non-numeric ID
    [Tags]    API    GetUser    Negative
    Set Tags    AllureSuite:Get User API
    Log    Fail to retrieve a user with a non-numeric ID
    Given I have a user ID    invalid_id
    When I request the user details
    Then the response status should be    404
    And the response should indicate user not found

*** Keywords ***
Given I have a user ID
    [Arguments]    ${user_id}
    Set Test Variable    ${USER_ID}    ${user_id}

When I request the user details
    ${response}=    Get Single User    ${USER_ID}
    ${status_code}=    Set Variable    ${response.status_code}
    ${json_response}=    Run Keyword If    ${status_code} == 200    Set Variable    ${response.json()}    ELSE    Create Dictionary
    Set Suite Variable    ${USER_RESPONSE}    ${json_response}
    Set Suite Variable    ${STATUS_CODE}    ${status_code}

Then the response status should be
    [Arguments]    ${expected_status}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${expected_status}
    Log    Expected status: ${expected_status}, Actual status: ${STATUS_CODE}

And the user details should be correct
    Run Keyword If    ${STATUS_CODE} == 200    Validate User Response

And the response should indicate user not found
    Log    User retrieval failed as expected
    Dictionary Should Not Contain Key    ${USER_RESPONSE}    data

Validate User Response
    Dictionary Should Contain Key    ${USER_RESPONSE}    data
    Dictionary Should Contain Key    ${USER_RESPONSE["data"]}    id
    Dictionary Should Contain Key    ${USER_RESPONSE["data"]}    email
    Dictionary Should Contain Key    ${USER_RESPONSE["data"]}    first_name
    Dictionary Should Contain Key    ${USER_RESPONSE["data"]}    last_name
    Dictionary Should Contain Key    ${USER_RESPONSE["data"]}    avatar
    Dictionary Should Contain Key    ${USER_RESPONSE}    support
    Dictionary Should Contain Key    ${USER_RESPONSE["support"]}    url
    Dictionary Should Contain Key    ${USER_RESPONSE["support"]}    text