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
${Cashflow_1}    1
${Cashflow_2}    2
${Facility_RowID}    1
${Customer_RowID}   1
${Deal_RowID}    1
${SCENARIO}    6
${Calendar_1}    1
${Calendar_2}    2

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 29 ARR Currency Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC07 - Validate currency calendar holiday accrual
    [Documentation]    This test cases validates currency calendar holiday accrual.
    [Tags]   Currency Calendar Holidays - TM01
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook        ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate No Published Rate for Calendar Holiday    ${ExcelPath}     ${Calendar_1}    TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate Published Rate for Calendar Holiday    ${ExcelPath}     ${Calendar_2}    TM01_CalendarHolidaysSetup