*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Send REST Request
    [Documentation]    Send a REST request using the JSON request and checks for the response code.
    ...    @author: anandan0    09DEC2020    - initial create
    ...    @update: cpaninga    13DEC2021    - migrated from FT to BNS, udpated LIQ_HOST and LIQ_ENDPOINT to BNS_HOST and BNS_ENDPOINT
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sStatusCode}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${StatusCode}    Acquire Argument Value    ${sStatusCode}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Create Session ###
    Delete All Sessions
    Create Session    ${APISESSION}    ${BNS_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/json
    ${JSON}    OperatingSystem.Get File    ${dataset_path}${InputFilePath}${InputFileName}.json
    ${Response}    Get Request    ${APISESSION}    ${BNS_ENDPOINT}    json=${JSON}    headers=${Headers}
    Set Global Variable    ${RESPONSE_GLOBAL}    ${Response.content}
    Log    Response=${Response.content}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Response.content}
    Log    ConvertedResponse=${Converted_Response}
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.json    ${Converted_Response}

    ### Validate Status Code ###
    Should Be Equal As Strings     ${Response.status_code}    ${StatusCode}
