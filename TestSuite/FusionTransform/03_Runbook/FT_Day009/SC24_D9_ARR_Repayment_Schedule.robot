*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Loan_2}    3
${Cashflow_3}    3
${Cashflow_4}    4
${Customer_RowID}   1
${Deal_RowID}    1
${Facility_RowID}    2
${Loan_RowID}    3
${SCENARIO}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 24 ARR Repayment Schedule     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC15 - Validate Increase Loan
    [Documentation]   This test case validates Increase Loan.
    [Tags]    ARR Loan Increase - SERV28
    Mx Execute Template With Multiple Data    Open Existing Loan for Loan Increase    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Increase Details at General Tab    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Set Loan Quick Repricing Spread Adjusment and Validate ARR Parameters    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Generate Intent Notices    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Release Cashflow    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Release    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 10)
    Pause Execution
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Increase in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease