*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup  Set Automation Suite
Test Teardown   Handle Teardown

*** Variables ***
${Deal_1}            1
${Facility_1}        1
${Loan_1}            1
${Customer_RowID}    1
${Facility_RowID}    1
${Loan_RowID}        1
${Deal_RowID}        1
${SCENARIO}          4
${rowid}             1
${Carry}             1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 27 ARR Secondary Trading     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day 10 ###
TC10 - Validate Updated Lender Shares
    [Documentation]    This test case validates the skim accruals and loan accruals for lenders with skim
    [Tags]    ARR Validate Updated Lender Shares
    Mx Execute Template With Multiple Data    Approve And Close The Assignment Sell    ${ExcelPath}    ${Carry}    TRP002_SecondarySale
    Log to Console    Pause Execution - Run (1) Day EOD (Day 10)
    Pause Execution
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Updated Lender Shares    ${ExcelPath}    ${Carry}    TRP002_SecondarySale