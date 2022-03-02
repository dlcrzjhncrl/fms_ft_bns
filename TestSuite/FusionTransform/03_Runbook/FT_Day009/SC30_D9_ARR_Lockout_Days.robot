*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}    1
${Payment_1}    1
${Cashflow_1}    1
${Cashflow_2}    2
${Deal_RowID}    1
${Facility_RowID}    2
${Loan_RowID}    1
${SCENARIO}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 30 ARR Lockout Days     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### No need to run this TC, this TC is already deprecated ###
# TC07 - Validate ARR Computation after Scheduled Principal Payment
#     [Documentation]   This test case validates ARR Computation after Scheduled Principal Payment.
#     [Tags]    ARR Loan Accrual - SERV01
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

# TC08 - Validate ARR Unscheduled Principal Payment with Repayment Schedule
#     [Documentation]   This test case validates ARR Unscheduled Principal Payment with Repayment Schedule.
#     [Tags]    ARR Unscheduled Principal Payment - SERV20
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Add Unscheduled Principal Payment    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Release Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Log to Console    Pause Execution - Run (1) Day EOD (Day 10)
#     Pause Execution