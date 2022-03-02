*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot

*** Keywords ***    
Update Key Values of input JSON file for Correspondence API
    [Documentation]    This keyword is used to update key values of JSON file and save to new file.
    ...    @author: cmartill/chanario    DDMMMYYYY    - initial create
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sMessageId}    ${sStatus}    ${sErrorMessage}    ${sInput_JsonFile}

    ### Keyword Pre-processing ###
    ${MessageId}    Acquire Argument Value    ${sMessageId}
    ${Status}    Acquire Argument Value    ${sStatus}
    ${ErrorMessage}    Acquire Argument Value    ${sErrorMessage}
    ${Input_JsonFile}    Acquire Argument Value    ${sInput_JsonFile}
    
    ${file_path}    Set Variable    ${templateinput}
    ${EMPTY}    Set Variable
    ${json_object}    Load JSON From File    ${file_path}

    ## add demographic fields here
    ${new_json}    Run Keyword If    '${MessageId}'=='null'    Set To Dictionary    ${json_object}    messageId=${NONE}
    ...    ELSE IF    '${MessageId}'==''    Set To Dictionary    ${json_object}    messageId=${EMPTY}
    ...    ELSE IF    '${MessageId}'=='Empty' or '${MessageId}'=='empty'    Set To Dictionary    ${json_object}    messageId=${EMPTY}
    ...    ELSE IF    '${MessageId}'=='no tag'    Set Variable    ${json_object}
    ...    ELSE    Set To Dictionary    ${json_object}    messageId=${MessageId}

    ${new_json}    Run Keyword If    '${Status}'=='null'    Set To Dictionary    ${new_json}    status=${NONE}
    ...    ELSE IF    '${Status}'==''    Set To Dictionary    ${new_json}    status=${EMPTY}
    ...    ELSE IF    '${Status}'=='Empty' or '${Status}'=='empty'    Set To Dictionary    ${new_json}    status=${EMPTY}
    ...    ELSE IF    '${Status}'=='no tag'    Set Variable    ${new_json}
    ...    ELSE    Set To Dictionary    ${new_json}    status=${Status}

    ${new_json}    Run Keyword If    '${ErrorMessage}'=='null'    Set To Dictionary    ${new_json}    errorMessage=${NONE}
    ...    ELSE IF    '${ErrorMessage}'==''    Set To Dictionary    ${new_json}    errorMessage=${EMPTY}
    ...    ELSE IF    '${ErrorMessage}'=='Empty' or '${ErrorMessage}'=='empty'    Set To Dictionary    ${new_json}    errorMessage=${EMPTY}
    ...    ELSE IF    '${ErrorMessage}'=='no tag'    Set Variable    ${new_json}
    ...    ELSE    Set To Dictionary    ${new_json}    errorMessage=${ErrorMessage}

    Log    ${new_json}
    ${converted_json}    Evaluate    json.dumps(${new_json})        json
    Log    ${converted_json}

    ${jsonfile}    Set Variable    ${Input_JsonFile}
    Delete File If Exist    ${dataset_path}${jsonfile}
    Create File    ${dataset_path}${jsonfile}    ${converted_json}
    ${file}    OperatingSystem.Get File    ${dataset_path}${jsonfile}
 
Create Session Correspondence
    [Documentation]    This keyword is used to create session for testing Correspondence API
    ...    @author: jaquitan    21MAR2019    - iniial create

    ${Resp}    Create Session    ${APISESSION}    ${API_CORRES_HOST}
    Log    ${Resp}