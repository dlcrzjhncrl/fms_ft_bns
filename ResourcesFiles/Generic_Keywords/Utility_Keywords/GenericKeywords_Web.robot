*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Return Expected User Status
    [Documentation]    This keyword is used to Return the correct expected User Status
    ...    @author: jloretiz    06SEP2019    - Initial create
    [Arguments]    ${sAPIDataSetVariable}    ${sResponseVariable}
    
    ${Expected}    Run Keyword If    '${sAPIDataSetVariable}'=='' or '${sAPIDataSetVariable}'==${NONE}    Set Variable    ${sResponseVariable}
    ...    ELSE IF    '${sAPIDataSetVariable}'=='ACTIVE'    Set Variable    INACTIVE
    ...    ELSE    Set Variable    ACTIVE
    
    [Return]    ${Expected}

Return No Tag Value for Empty Variables
    [Documentation]    This keyword is used to Return no tag value for Empty Variables
    ...    @author: jloretiz    06SEP2019    - Initial create
    [Arguments]    ${sVariable}
    
    ${EmptyList}    Create List
    ${Expected}    Run Keyword If    '${sVariable}'=='${EmptyList}' or '${sVariable}'=='${NONE}'     Set Variable    no tag
    ...    ELSE    Set Variable    ${sVariable}
    
    [Return]    ${Expected}
    
Get API Response from File for PUT and POST User API
    [Documentation]    This keyword is used to get API Response from File for PUT and POST User API
    ...    @author: amansuet    17SEP2019    - Initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputAPIResponse}    ${sHttpMethod}
    
    ${APIResponseFile}    OperatingSystem.Get File    ${dataset_path}${sOutputFilePath}${sOutputAPIResponse}.json
    
    Run Keyword If    '${sHttpMethod}'=='PUT'    Set Global Variable    ${PUTAPIRESPONSE}    ${APIResponseFile}
    ...    ELSE IF    '${sHttpMethod}'=='POST'    Set Global Variable    ${POSTAPIRESPONSE}    ${APIResponseFile}
    ...    ELSE    Fail    '${sHttpMethod}' method is not applicable for this keyword.

Return Expected User Lock Status
    [Documentation]    This keyword is used to Return the correct expected User Status
    ...    @author: jloretiz    06SEP2019    - Initial create
    [Arguments]    ${sStatus}
    
    ${Expected}    Run Keyword If    '${sStatus}'=='LOCKED'    Set Variable    UNLOCKED
    ...    ELSE    Set Variable    LOCKED
    
    [Return]    ${Expected}

Return GET API Response Data If APIDataSet is Empty
    [Documentation]    This keyword is used to Return the GET API Response Data if APIDataSet is empty.
    ...    @author: jloretiz    09SEP2019    - Initial create
    [Arguments]    ${sAPIDataSetVariable}    ${sResponseVariable}
    
    ${Expected}    Run Keyword If    '${sAPIDataSetVariable}'=='' or '${sAPIDataSetVariable}'==${NONE}    Set Variable    ${sResponseVariable}
    ...    ELSE    Set Variable    ${sAPIDataSetVariable}
    
    [Return]    ${Expected}

Clear Windows App Textfield
    [Documentation]    This keyword is used to Clear Windows App Textfield.
    ...    @author: hstone    23SEP2020    - initial create
    [Arguments]    ${sLocator}

    Mx LoanIQ Click Left Mouse    ${sLocator}
    Mx Select All
    Mx Press Combination    Key.BACKSPACE
    
Send SOAP Request for RunXQuery
	[Documentation]    Send a SOAP request using the created XML request for RunXQuery 
    ...    @author: ShwetaJagtap    09OCT2020    - initial create
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sOutputFilePath}    ${sOutputFileName}    
    
     ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    
    Delete All Sessions
    Create Session    ${APISESSION}    ${LIQ_RUNXQUERY_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/xml; charset=utf-8
    ${XML}    OperatingSystem.Get File    ${dataset_path}${InputFilePath}${InputFileName}.xml
    ${Response}    Post Request    ${APISESSION}    ${LIQ_ENDPOINT}    ${XML}    headers=${Headers}
    Set Global Variable    ${RESPONSE_GLOBAL}    ${Response.content}
    Log    Response=${Response.content}
    ${xml1} =    Parse Xml    ${Response.content}
    Create Binary File    ${dataset_path}${sOutputFilePath}${sOutputFileName}.xml      ${Response.content}
    
Validate RunXQuery SOAP API Response
    [Documentation]    Validate RunXQuery SOAP API Response and checks for the response code.
    ...    @author: ShwetaJagtap    09OCT2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    
    
    ${XML}    OperatingSystem.Get File    ${dataset_path}${sOutputFilePath}${sOutputFileName}.xml
    
    ${RunXQueryResponse}    Get Element   ${XML}    *//RunXQueryResponse
    ${SuccessResponse} =    Set Variable    ${RunXQueryResponse.attrib['success']}

    ${test2}    Get Element   ${XML}     *//RunXQueryResults
    ${queryResult} =    Set Variable    ${test2.attrib['queryResult']}
    Run Keyword If	'${SuccessResponse}'=='true' and '${queryResult}'!=''	Log    Validate API Response 
    
Send POST Request for MTO Update Payment
    [Documentation]    Send a REST request using the JSON request and checks for the response code.
    ...    @author: jdelacru    10DEC2020    - initial create
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sStatusCode}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${StatusCode}    Acquire Argument Value    ${sStatusCode}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Create Session ###
    Delete All Sessions
    Create Session    ${APISESSION}    ${LIQ_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/json
    ${JSON}    Load JSON From File    ${dataset_path}${InputFilePath}${InputFileName}.json
    ${Response}    Post Request    ${APISESSION}    ${LIQ_MTO_UPDATEPAYMENT_ENDPOINT}    json=${JSON}    headers=${Headers}
    Set Global Variable    ${RESPONSE_FILE}    ${Response.content}
    Set Global Variable    ${API_RESPONSE}    ${Response}
    Log    Response=${Response.content}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Response.content}
    Log    ConvertedResponse=${Converted_Response}
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.json    ${Converted_Response}

    ### Validate Status Code ###
    ${StatusCode}    Convert To Integer    ${StatusCode}    
    Run Keyword and Continue on Failure    Should Be Equal As Strings     ${Response.status_code}    ${StatusCode}
    
Send REST Request
    [Documentation]    Send a REST request using the JSON request and checks for the response code.
    ...    @author: anandan0    09DEC2020    - initial create
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sStatusCode}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${StatusCode}    Acquire Argument Value    ${sStatusCode}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Create Session ###
    Delete All Sessions
    Create Session    ${APISESSION}    ${LIQ_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/json
    ${JSON}    OperatingSystem.Get File    ${dataset_path}${InputFilePath}${InputFileName}.json
    ${Response}    Get Request    ${APISESSION}    ${LIQ_ENDPOINT}    json=${JSON}    headers=${Headers}
    Set Global Variable    ${RESPONSE_GLOBAL}    ${Response.content}
    Log    Response=${Response.content}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Response.content}
    Log    ConvertedResponse=${Converted_Response}
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.json    ${Converted_Response}

    ### Validate Status Code ###
    Should Be Equal As Strings     ${Response.status_code}    ${StatusCode}

Send GET Request for MTO FetchPending Payment
    [Documentation]    Send a REST request using the JSON request for MTO FetchPending and checks for the response code.
    ...    @author: mduran    12JAN2021    - initial create
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sStatusCode}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${StatusCode}    Acquire Argument Value    ${sStatusCode}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Create Session ###
    Delete All Sessions
    Create Session    ${APISESSION}    ${LIQ_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/json
    ${JSON}    OperatingSystem.Get File    ${dataset_path}${InputFilePath}${InputFileName}.json
    ${Response}    Get Request    ${APISESSION}    ${LIQ_MTO_FETCHPENDING_ENDPOINT}    json=${JSON}    headers=${Headers}
    Set Global Variable    ${RESPONSE_GLOBAL}    ${Response.content}
    Log    Response=${Response.content}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Response.content}
    Log    ConvertedResponse=${Converted_Response}
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.json    ${Converted_Response}

    ### Validate Status Code ###
    Should Be Equal As Strings     ${Response.status_code}    ${StatusCode}

Validate SOAP API Response
    [Documentation]    This keyword validates the response from the expected response created on the pre-requisite.
    ...    @author: jloretiz    12SEP2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${sOutputExpectedFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${OutputExpectedFileName}    Acquire Argument Value    ${sOutputExpectedFileName}

    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.xml
    ${ExpectedReponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputExpectedFileName}.xml

    ${Converted_ExpectedReponse}    Remove String    ${ExpectedReponse}    \n    \t    ${space}
    ${Converted_ActualResponse}    Remove String    ${ActualResponse}    \n    \t    ${space}

    Should Be Equal As Strings     ${Converted_ActualResponse}    ${Converted_ExpectedReponse}

Send SOAP Request
    [Documentation]    Send a SOAP request using the created XML request and checks for the response code.
    ...    @author: jloretiz    12SEP2020    - initial create
    [Arguments]    ${sInputFilePath}    ${sInputFileName}    ${sStatusCode}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputFileName}    Acquire Argument Value    ${sInputFileName}
    ${StatusCode}    Acquire Argument Value    ${sStatusCode}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Create Session ###
    Delete All Sessions
    Create Session    ${APISESSION}    ${LIQ_HOST}

    ### Send POST Request ###
    &{Headers}    Create Dictionary    Content-Type=application/xml; charset=utf-8
    ${XML}    OperatingSystem.Get File    ${dataset_path}${InputFilePath}${InputFileName}.xml
    ${Response}    Post Request    ${APISESSION}    ${LIQ_ENDPOINT}    ${XML}    headers=${Headers}
    Set Global Variable    ${RESPONSE_GLOBAL}    ${Response.content}
    Log    Response=${Response.content}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Response.content}
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.xml    ${Converted_Response}

    ### Validate Status Code ###
    Should Be Equal As Strings     ${Response.status_code}    ${StatusCode}

### TACOE KEYWORDS ###
Mx Click Element
    [Arguments]    ${locator}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    1s
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Element    ${locator}
    Wait Until Browser Ready State

Mx Double Click Element
    [Arguments]    ${locator}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    1s
    Wait Until Browser Ready State
    Set Focus to Element    ${locator}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Double Click Element    ${locator}
    Wait Until Browser Ready State

Mx Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    1s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Element    ${locator}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Clear Element Text    ${locator}
    Press Keys    ${locator}    TAB
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Input Text    ${locator}    ${text}
    Press Keys    ${locator}    TAB
    Wait Until Browser Ready State
  
Mx Input Amount
    [Arguments]    ${locator}    ${AllData}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    50s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}    50s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    50s
    Clear Element Text    ${locator}
    Click Element    ${locator}
    Press Key    ${locator}    ${AllData}    
    Press Key    ${locator}    \\11
    
Mx Compare
    [Arguments]    ${locator}    ${AllData}
    ${Actual_Value}    Mx Get Element Attribute    ${locator}    value
    Log To Console    ${Actual_Value}
    ${Expected}    Decode Bytes To String    ${AllData}    ASCII
    ${Actual_Value}    Replace String    ${Actual_Value}    ,    ${empty}
    ${Actual_Value}    Replace String    ${Actual_Value}    \n    ${empty}                   
    ${true}    Run Keyword And Return Status    Should Be Equal    ${Actual_Value}       ${Expected}          
    Log To Console    ${true}
    Set Global Variable    ${true}

Mx Get Text
    [Arguments]    ${locator}
    [Return]    ${returned_text}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    10s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    10s
    ${returned_text}    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Get Text    ${locator}
    Should Not Be Empty    ${returned_text}  
    
Mx Get Element Attribute
    [Arguments]    ${locator}    ${attribute}
    [Return]    ${returned_text}
    Wait Until Browser Ready State
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Page Contains Element    ${locator}    10s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Visible    ${locator}    20s
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Wait Until Element Is Enabled    ${locator}    10s
    ${returned_text}    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Get Element Attribute    ${locator}@${attribute}
    Should Not Be Empty    ${returned_text}          
       
Mx Select option from list
    [Arguments]   ${fieldlocator}    ${name}    ${listname}
    Wait Until Element Is Enabled    ${fieldlocator}    20s
    Clear Element Text    ${fieldlocator}
    Wait Until Keyword Succeeds    20x    2s    Input Text    ${fieldlocator}     ${name}
    Wait Until Keyword Succeeds    20x    2s    Click Element    ${listname}

Mx Move To Frame
    [Documentation]    Moves to number of frames as passed in argument.
    [Arguments]  @{List}
    :FOR    ${frame}    IN    @{List}
    \    Wait Until Page Contains Element    ${frame}    30s
    \    ${Status}    Run Keyword And Return Status    Select Frame    ${frame}
    [Return]    ${Status}
    
Mx Move To Frame And Click Element
    [Documentation]    Moves to number of frames till the element is found and click on that element. 
    [Arguments]    ${element}    ${list}
    Wait Until Browser Ready State
    ${Status}    Mx Move To Frame    @{list}
    Run Keyword If    '${Status}' == 'True'    Wait Until Page Contains Element    ${element}    10s    ELSE    Fail    Frame is not selected
    Wait Until Element Is Visible    ${element}    10s
    # Sleep    3s
    Click Element    ${element}
    Unselect Frame
    
Mx Move To Frame And Input Text
    [Documentation]    Moves to number of frames till the element is found and click on that element. 
    [Arguments]    ${element}    ${text}    ${list}
    ${Status}    Mx Move To Frame    @{list}
    Run Keyword If    '${Status}' == 'True'    Wait Until Page Contains Element    ${element}    10s    ELSE    Fail    Frame is not selected
    Wait Until Element Is Enabled    ${element}    10s
    Sleep    3s
    Mx Input Text    ${element}    ${text}
    Unselect Frame

Mx Set IE Capabilities
    [Documentation]    Keyword is used to set desired IE capabilities to launch tests on IE browser.
    ${defaultIECapabilities}=    Evaluate    sys.modules["selenium.webdriver"].DesiredCapabilities.INTERNETEXPLORER    sys,selenium.webdriver
    Set To Dictionary    ${defaultIECapabilities}    ignoreZoomSetting=${TRUE}
    Set To Dictionary    ${defaultIECapabilities}    nativeEvents=${FALSE}
    Set To Dictionary    ${defaultIECapabilities}    ignoreProtectedModeSettings=${TRUE}
    Set To Dictionary   ${defaultIECapabilities}   ie.browserCommandLineSwitches=-private

Wait Until Browser Ready State
    Execute Javascript    return window.load
    :FOR    ${i}    IN RANGE    1    200
    \    ${ready_status}    Execute Javascript    return document.readyState
    \    Exit For Loop If    "${ready_status}"=="complete"
    \    Sleep    1s      
    
Mx Check for a leap Year
    [Arguments]    ${Date}
    [Return]    ${noofdays}
    ${Date}    Get Current Date    result_format=%Y-%m-%d
    ${datetime}    Convert Date    ${Date}     datetime
    ${leapyear}    Run Keyword And Continue On Failure    Evaluate    ${datetime.year}/4.00    
    ${strleap}    Convert To String    ${leapyear}    
    ${split}    Split String    ${strleap}    separator=.
    ${noofdays}    Run Keyword If    "${split.pop(1)}"=="0"    Set Variable    366    ELSE    Set Variable    365
    Log To Console    ${noofdays}
    
Mx Open LIQ and UFT
    Mx Launch UFT    Visibility=True    UFTAddins=Java    Processtimeout=200
    Mx LoanIQ Launch    Processtimeout=300