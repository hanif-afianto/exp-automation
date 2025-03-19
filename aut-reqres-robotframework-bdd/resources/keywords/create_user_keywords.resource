*** Settings ***
Library    RequestsLibrary
Resource    ../../resources/variables/user_variables.resource

*** Keywords ***
Create New User
    [Arguments]    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST    ${BASE_URL}/users    data=${payload}    expected_status=any
    RETURN    ${response}

Verify User Name
    [Arguments]    ${response}    ${expected_name}
    Should Be Equal As Strings    ${response["name"]}    ${expected_name}

Verify User Job
    [Arguments]    ${response}    ${expected_job}
    Should Be Equal As Strings    ${response["job"]}    ${expected_job}
