*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Facility_1}    1
${Facility_2}    2
${Primaries_1}    1
${Primaries_2}    2
${Loan_1}    1
${Cashflow_1}    1
${Cashflow_2}    2
${Facility_RowID}    1
${Customer_RowID}   1
${Deal_RowID}    1
${SCENARIO}    6
${Calendar_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 29 ARR Currency Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC06B - Loan Accrual Validation Day 1
    [Documentation]    This test case validates Loan Accrual validation Day 1 (after batch run).
    [Tags]   Currency Calendar Holidays - TM01
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook        ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log     Run EOD until Branch Holiday (Day 4)