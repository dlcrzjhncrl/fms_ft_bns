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

### Day (12) ###
TC13 - Loan Accrual Validation with LBRF and BRF are not null - Part 2
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Repricing with LBRF is not null
    [Tags]   ARR Loan Accrual Validation - SERV25
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    7
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType