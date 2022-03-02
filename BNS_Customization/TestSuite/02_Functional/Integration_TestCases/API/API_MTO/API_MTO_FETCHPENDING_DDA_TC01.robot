*** Settings ***
Resource    ../../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot

Suite Setup    Test Suite Setup    Scenario 1 MTO Fetch Pending DDA    ${INTEGRATION_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${REPORT_MAKER}    OFF

*** Test Cases ***
TC01 - BNS_MTO_FetchPendingDDA_TC01_AUTO
	[Documentation]    This keyword will send valid JSON request and verify it matches in LoanIQ database.
    ...    @author: anandan0    08DEC2020    - initial create
    ...    @update: cpaninga    16DEC2021    - migrate BNS to FT format
    [Tags]    BNS_MTO_FetchPendingDDA_TC01_AUTO
    Execute    Get Pending DDA    MTOFetchPaymentDDA    ${rowid}    
