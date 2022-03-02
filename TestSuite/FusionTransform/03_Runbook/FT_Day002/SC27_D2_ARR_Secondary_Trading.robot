*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}            1
${Sell}              1


*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 27 ARR Secondary Trading     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day 2 ###
TC07AB - Release Cashflows and Validate Accrual After EOD
    [Documentation]    This test case validates the release cashflow and loan accrual validation day
    [Tags]   ARR    Release Cashflows and loan accrual validation
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 2)
    Pause Execution
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Drawdown Rate and Accrued Interest    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC08 - Assignment Sell With Delayed Compensation
    [Documentation]    This test case validates the assignment sell with delayed compensation
    [Tags]    ARR    Assignment Sell    Delayed Compensation
    Mx Execute Template With Multiple Data    Set up Assignment Sell With Delayed Compensation    ${ExcelPath}    ${Sell}    TRP002_SecondarySale

