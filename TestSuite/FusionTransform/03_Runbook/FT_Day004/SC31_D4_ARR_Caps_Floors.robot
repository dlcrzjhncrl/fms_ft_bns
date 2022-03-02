*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Loan_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 31 ARR Caps and Floors     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC08 - Create Loan 2 with Base Rate Floor - Part 2
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC09 - Delete Base Rate Floor in Loan 2 - Part 1
    [Documentation]   This test case validates the rate used after deletion of the base rate floor 
    [Tags]    ARR Loan Drawdown with Base Rate Floor Deleted - SERV01
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Delete And Validate Base Rate Floor    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 5)
    Pause Execution