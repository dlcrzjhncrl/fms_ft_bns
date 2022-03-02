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
${Facility_RowID}    1
${SCENARIO}    1
${Payment_RowID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 30 ARR Lockout Days     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (6) ###
TC06 - Validate ARR Interest Payment Notice
    [Documentation]   This test case validates ARR Interest Payment Notice.
    [Tags]    ARR Interest Payment Notice - SERV21    SC07_TC06
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
    Mx Execute Template With Multiple Data    Confirm Interest Payment Made   ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment