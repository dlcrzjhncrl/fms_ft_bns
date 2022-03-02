*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}    1
${Deal_RowID}    1
${Facility_RowID}    2
${Loan_RowID}    1
${SCENARIO}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 30 ARR Lockout Days     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### No need to run this TC, this TC is already deprecated ###
# TC09 - Validate ARR Computation after Unscheduled Principal Payment with Repayment Schedule
#     [Documentation]   This test case validates ARR Computation after Unscheduled Principal Payment with Repayment Schedule.
#     [Tags]    ARR Loan Accrual - SERV01
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown