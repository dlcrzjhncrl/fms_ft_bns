*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}    1
${Payment_1}    1
${Cashflow_1}    1
${Cashflow_2}    2


*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 28 ARR Branch Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### No need to run all these TCs below, these are already deprecated ###
# TC10 - Validate ARR - scheduled principal payment accrual validation
#     [Documentation]    This test case validates the ARR accrual for scheduled principal payment
#     [Tags]    ARR Scheduled Principal Payment - SERV18
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment

# TC11 - Loan Accrual Validation Day
#     [Documentation]    This test case validates the loan accrual validation day
#     [Tags]   ARR Loan Accrual Validation Day
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

# TC12 - Validate ARR Unscheduled Principal Payment with Repayment Schedule
#     [Documentation]    This test case validates the ARR unscheduled principal payment with repayment schedules
#     [Tags]    ARR Unscheduled Principal Payment - SERV20
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Add Unscheduled Principal Payment    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
#     Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Validate Principal Loan Repayment in Loan Notebook    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
