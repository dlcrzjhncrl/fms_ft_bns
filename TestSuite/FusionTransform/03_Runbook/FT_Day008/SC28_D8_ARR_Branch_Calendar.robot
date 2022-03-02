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

### No need to run this TC, this TC is already deprecated ###
# TC10 - Validate ARR - scheduled principal payment
#     [Documentation]    This test case validates the ARR scheduled principal payment
#     [Tags]    ARR Scheduled Principal Payment - SERV18
#     Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Create Pending Transaction for Scheduled Payment    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Get Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_1}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
#     Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment