*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Deal_1}    1
${Deal_RowID}     1
${Loan_RowID}     1
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_1}    1
${Loan_2}    3
${Loan_3}    5
${Loan_4}    7
${Repricing_1}    1
${Repricing_2}    2
${Repricing_NewID}    1
${Repricing_3}    3
${Repricing_4}    4
${Repricing_5}    5
${Repricing_6}    6
${Repricing_7}    7
${Repricing_8}    8

*** Test Cases ***    
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 26 ARR LIBOR Conversion     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (3) ###
TC06 - Perform a Comprehensive Repricing - from Libor to SOFR
    [Documentation]  This will create a comprehensive repricing of Loan # 1 from Libor to SOFR
    [Tags]   ARR Outstanding Loan - SERV10
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_2}    SERV10_ConversionOfInterestType

TC07 - Repricing Create Cashflow and Validate Intent Notice
    [Documentation]  This will create a cashflow and generate intent notice.
    [Tags]  ARR Outstanding Loan - SERV10
    Set Test Variable    ${isForRepricingNoticeHoliday}    ${TRUE}
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_2}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Interest Payment        ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC08 - Loan Accrual Validation of Comprehensive Repricing
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Repricing
    [Tags]   ARR Loan Accrual Validation - SERV25
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC09 - Perform a Quick Repricing - from Libor to SOFR
    [Documentation]  This will create a quick repricing of Loan # 2 from Libor to SOFR
    [Tags]   ARR Outstanding Loan - SERV08
    Set Test Variable   ${Loan_RowID}     3
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Quick Repricing    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input General Details on Loan Quick Repricing    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Host of Funds    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_4}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Rate Setting Notice and Validate Notice        ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Repricing_4}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType

TC10 - Loan Accrual Validation of Quick Repricing
    [Documentation]    This test case validates the loan accrual validation day for Quick Repricing
    [Tags]   ARR Loan Accrual Validation - SERV25
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    3
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Log to Console    Pause Execution - Run (7) Day EOD (Day 10)
    Pause Execution