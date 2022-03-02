*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Get the MessageId Decode Value
    [Documentation]    This keyword is used to get the MessageId Decode using CorrelationID
    ...    @author: fluberio    28OCT2020    - initial create
    [Arguments]    ${sCorrelationID}

    ${CorrelationIdByte}    Encode String To Bytes    ${sCorrelationID}     UTF-8
    ${MessageIdEncode}    B 32 Encode    ${CorrelationIdByte}
    ${MessageIdDecode}    Decode Bytes To String    ${MessageIdEncode}    UTF-8
    [Return]    ${MessageIdDecode}
    
Post Json File
    [Documentation]    Send a Post Request using sAPIEndPoint and sAccessToken. Data to be sent is from sInputFile
    ...    and response will be saved to sOutputFile.
    ...    @update: mnanquil    26FEB2019    - added optional argument to handle adding of access token.
    ...    @update: clanding    22MAR2019    - added ${dataset_path} and .json file extension, refactor
    ...    @update: rtarayao    14JAN2020    - added optional argument to handle request with Zone as one of the headers
    ...    @update: cbautist    14JUN2021    - updated accessing dictionary from &{Headers1} to ${Headers1}
    [Arguments]    ${sInputPath}    ${sInputFile}    ${sAPIEndPoint}    ${sOutputPath}    ${sOutputFile}    ${sAccessToken}=None    ${sZone}=None
    
    ${Headers1}    Run Keyword If    '${sAccessToken}' != 'None' and '${sZone}' != 'None'    Create Dictionary    Content-Type=application/json    Zone=${sZone}    Authorization=${sAccessToken}
    ...    ELSE IF    '${sAccessToken}' != 'None' and '${sZone}' == 'None'    Create Dictionary    Content-Type=application/json    Authorization=${sAccessToken}
    ...    ELSE IF    '${sAccessToken}' == 'None' and '${sZone}'=='None'    Create Dictionary    Content-Type=application/json; charset=utf-8;
    ...    ELSE IF    '${sAccessToken}' == 'None' and '${sZone}' != 'None'    Create Dictionary    Content-Type=application/json    charset=utf-8    Zone=${sZone}
    Set Global Variable    ${Headers}    ${Headers1}

    ${InputJsonFile}    OperatingSystem.Get File    ${dataset_path}${sInputPath}${sInputFile}.json
    ${API_RESPONSE}    Post Request    ${APISESSION}    ${sAPIEndPoint}    ${InputJsonFile}    headers=${Headers}
    Set Global Variable    ${API_RESPONSE}
    Log    POST Json Response: ${API_RESPONSE.content}
    ${API_RESPONSE_STRING}    Convert To String    ${API_RESPONSE.content}
    Create file    ${dataset_path}${sOutputPath}${sOutputFile}.json    ${API_RESPONSE_STRING}
    ${RESPONSE_FILE}    OperatingSystem.Get File    ${dataset_path}${sOutputPath}${sOutputFile}.json
    Log    ${RESPONSE_FILE}
    Set Global Variable    ${RESPONSE_FILE}
    [Return]    ${API_RESPONSE.content}  

Verify Json Response Status Code
    [Documentation]    This keyword is used to verify if response status code is equal to expected response status code.
    ...    @author: clanding    22MAR2019    - initial create
    [Arguments]    ${iExpected_ResponseCode}
    
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${iExpected_ResponseCode}    ${API_RESPONSE.status_code}
    ${Resp_Status}    Run Keyword And Return Status    Should Be Equal As Strings    ${iExpected_ResponseCode}    ${API_RESPONSE.status_code}
    Run Keyword If    ${Resp_Status}==${True}    Log    Response Status Code are matched! ${iExpected_ResponseCode} == ${API_RESPONSE.status_code}     
    ...    ELSE IF    ${Resp_Status}==${False}    Log    Response Status Code are NOT matched! ${iExpected_ResponseCode} != ${API_RESPONSE.status_code}    level=ERROR
    
    Log    JSON Request has been created.
    ${Resp_Stat_Code}    Convert To String    ${API_RESPONSE.status_code}
    Set Global Variable    ${Resp_Stat_Code}