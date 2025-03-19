*** Settings ***
Library    RequestsLibrary
Resource    ../../resources/variables/user_variables.resource

*** Keywords ***
Get Single User
    [Arguments]    ${user_id}
    ${response}=    GET    ${BASE_URL}/users/${user_id}    expected_status=any
    RETURN    ${response}
