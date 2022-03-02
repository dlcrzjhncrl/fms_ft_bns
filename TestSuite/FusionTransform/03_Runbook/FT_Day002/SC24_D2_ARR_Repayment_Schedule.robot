*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Loan_1}    1
${Loan_2}    3
${Payment_1}    1
${Facility_RowID}    2
${SCENARIO}    1
${Loan_RowID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 24 ARR Repayment Schedule     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC07 - Validate ARR Computation after Loan Accrual
    [Documentation]   This test case validates ARR Computation after Loan Accrual.
    [Tags]    ARR Loan Accrual - SERV01
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC13 - Validate ARR Billing
    [Documentation]   This test case validates ARR ARR Billing.
    [Tags]    ARR Interest Payment Notice - SERV21
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Create Bills for Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Billing Templates    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Mx Execute Template With Multiple Data    Send Billing Validate ARR Details    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Log to Console    Pause Execution - Run (1) Day EOD (Day 3)
    Pause Execution