*** Settings ***
Resource    ../../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot

*** Keywords ***
Get Pending DDA
    [Documentation]    This keywords is used to sends a REST request to Fetch Pending IMT.
    ...    And validates if data Row Count Matches LoanIQ database correctly.
    ...    @author: Anandan0    10DEC2020    - initial create
    [Arguments]    ${APIDictionary}
    
     ### SEND GET PENDING DDA REQUEST ###
     Send REST Request    ${APIDictionary}[InputFilePath]    ${APIDictionary}[Test_Case]    ${RESPONSECODE_200}    ${APIDictionary}[OutputFilePath]    ${APIDictionary}[OutputResponseFile]

     ### GET JSON RECORD COUNT IN RESPONSE JSON###
     ${JsonTotalRecord}    Get RecordCount from JSON    ${APIDictionary}[OutputFilePath]    ${APIDictionary}[OutputResponseFile]    ${APIDictionary}[Searched_Tag]    ${APIDictionary}[Searched_Value]
    
     ###Check BNS Database for Pending DDA Record#
     Validate Database Record Count For Input Query    ${APIDictionary}[PositiveScenarioQuery]    ${APIDictionary}[PositiveScenarioWhereClause]    ${JsonTotalRecord}    ${APIDictionary}[PositiveScenario]
        