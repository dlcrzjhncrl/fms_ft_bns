*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Loan_1}    1
${Cashflow_1}    1
${Cashflow_2}    2
${Cashflow_3}    3
${Cashflow_4}    4
${Payment_1}    1
${Payment_3}    3
${Customer_RowID}   1
${Deal_RowID}    1
${Facility_RowID}    2
${Loan_RowID}    1
${SCENARIO}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 24 ARR Repayment Schedule     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC12 - Validate ARR Interest Payment Notice
    [Documentation]   This test case validates ARR Interest Payment Notice.
    [Tags]    ARR Interest Payment Notice - SERV21
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Select Prorate on Cycles for Loan    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Input Interest Payment General Tab Details    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Another Cashflow    ${ExcelPath}     ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Payment_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Approval    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment

TC14 - Validate Accrual Items after Scheduled Principal Payment
    [Documentation]   This test case validates Accrual Items after Scheduled Principal Payment.
    [Tags]    ARR Scheduled Principal Payment - SERV20
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Pending Transaction for Scheduled Payment    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Get Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 9)
    Pause Execution