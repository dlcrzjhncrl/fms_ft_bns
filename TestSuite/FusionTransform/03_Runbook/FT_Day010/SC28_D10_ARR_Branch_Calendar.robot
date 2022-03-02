*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 28 ARR Branch Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### No need to run this TC, this TC is already deprecated ###
# TC13 - Loan Accrual Validation 
#     [Documentation]    This test case validates the loan accrual validation
#     [Tags]   ARR Loan Accrual Validation Day
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate ARR OPS Specific Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown