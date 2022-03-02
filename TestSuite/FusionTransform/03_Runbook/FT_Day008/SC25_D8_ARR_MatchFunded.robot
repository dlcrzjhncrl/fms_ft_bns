*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Facility_1}    1
${Facility_2}    2
${Primaries_1}    1
${Primaries_2}    2
${Loan_1}    1
${Loan_2}    3
${Cashflow_1}    1
${Cashflow_2}    2
${Cashflow_3}    3
${Cashflow_4}    4
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_RowID}   1
${Deal_RowID}    1
${SCENARIO}    2
${Calendar_1}    1
${Payment_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 25 ARR Match Funded     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC09 - Validate Line Items and Accrual - Part1
    [Documentation]    This test case validates accrual items when Paperclip Payment is made in Loan #1
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Paperclip Payment for Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Generate Intent Notices   ${ExcelPath}    ${Loan_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paperclip Approval    ${ExcelPath}    ${Loan_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Proceed with Paperclip Releasing    ${ExcelPath}    ${Loan_1}    CRED01_DealSetup
    Log to Console    Pause Execution - Run (6) Days EOD (Day 8)
    Pause Execution
	
TC09 - Validate Line Items and Accrual - Part2
    [Documentation]    This test case validates accrual items when Paperclip Payment is made in Loan #1
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC10 - Validate the Line Items - Part1
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment (no Schedule) is made in Loan #2
    [Tags]    Unscheduled Principal Payment - SERV20
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Input Principal Payment General Tab Details    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Approval    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Log to Console    Pause Execution - Run (6) Days EOD (Day 8)
    Pause Execution
	
TC10 - Validate the Line Items - Part2
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment (no Schedule) is made in Loan #2
    [Tags]    Unscheduled Principal Payment - SERV20
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
