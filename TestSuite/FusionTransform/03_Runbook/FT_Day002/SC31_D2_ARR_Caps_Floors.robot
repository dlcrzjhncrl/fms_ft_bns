*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Loan_1}    1
${Cashflow_1}    1
${Cashflow_2}    2
${Payment_1}    1
${Payment_RowID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 31 ARR Caps and Floors     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC05 - Loan Accrual Validation
    [Documentation]    This test case validates the loan accrual validation day
    [Tags]   ARR Loan Accrual Validation Day
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06 - Validate Interest Payment Notice
    [Documentation]   This test case validates the Interest Payment Notice.
    [Tags]    Interest Payment Notice - SERV21
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Select Prorate on Cycles for Loan    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Input Interest Payment General Tab Details    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Another Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Payment_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Approval    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Interest Payment Made    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment

TC07 - Validate ARR Billing
    [Documentation]   This test case validates ARR ARR Billing.
    [Tags]    ARR Interest Payment Notice - SERV21
    Mx Execute Template With Multiple Data    Create Bills via Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Billing Templates    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Mx Execute Template With Multiple Data    Send Billing Validate ARR Details    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling

TC08 - Create Loan 2 with Base Rate Floor - Part 1
    [Documentation]   This test case validates the creation of loan 2 with base rate floor.
    [Tags]    ARR Loan Drawdown with Base Rate Floor - SERV01
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Setup Base Rate Floor    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 3)
    Pause Execution